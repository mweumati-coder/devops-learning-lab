"""Small Flask service used throughout the DevOps Learning Lab.

Endpoints:
  GET /          greeting plus a hit counter stored in Redis (or memory)
  GET /health    liveness/readiness probe
  GET /metrics   Prometheus metrics
"""
import os
import time

from flask import Flask, Response, jsonify

app = Flask(__name__)

REDIS_URL = os.getenv("REDIS_URL", "")
APP_VERSION = os.getenv("APP_VERSION", "dev")

_memory_hits = 0
_request_count = 0
_started = time.time()

_redis = None
if REDIS_URL:
    try:
        import redis

        _redis = redis.Redis.from_url(REDIS_URL, socket_connect_timeout=2)
    except ImportError:
        _redis = None


def _next_hit() -> int:
    """Increment and return the hit counter, falling back to memory."""
    global _memory_hits
    if _redis is not None:
        try:
            return int(_redis.incr("hits"))
        except Exception:
            pass  # Redis unreachable: degrade gracefully
    _memory_hits += 1
    return _memory_hits


@app.before_request
def _count_request():
    global _request_count
    _request_count += 1


@app.get("/")
def index():
    return jsonify(
        message="Hello from the DevOps Learning Lab",
        version=APP_VERSION,
        hits=_next_hit(),
        backend="redis" if _redis is not None else "memory",
    )


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/metrics")
def metrics():
    uptime = time.time() - _started
    body = (
        "# HELP app_requests_total Total HTTP requests received.\n"
        "# TYPE app_requests_total counter\n"
        f"app_requests_total {_request_count}\n"
        "# HELP app_uptime_seconds Seconds since the app started.\n"
        "# TYPE app_uptime_seconds gauge\n"
        f"app_uptime_seconds {uptime:.2f}\n"
    )
    return Response(body, mimetype="text/plain; version=0.0.4")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8000")))
