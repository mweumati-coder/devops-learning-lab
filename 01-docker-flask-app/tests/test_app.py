import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "app"))

import main  # noqa: E402


def client():
    main.app.config["TESTING"] = True
    return main.app.test_client()


def test_health_returns_ok():
    resp = client().get("/health")
    assert resp.status_code == 200
    assert resp.get_json() == {"status": "ok"}


def test_index_counts_hits():
    c = client()
    first = c.get("/").get_json()["hits"]
    second = c.get("/").get_json()["hits"]
    assert second == first + 1


def test_metrics_exposes_prometheus_format():
    body = client().get("/metrics").get_data(as_text=True)
    assert "app_requests_total" in body
    assert "# TYPE app_uptime_seconds gauge" in body
