# syntax=docker/dockerfile:1

# ---- Stage 1: build dependencies into wheels ----
FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# ---- Stage 2: small runtime image ----
FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

# Run as an unprivileged user
RUN useradd --create-home --uid 10001 appuser
WORKDIR /home/appuser

COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels /wheels/* \
    && rm -rf /wheels

COPY app/ ./app/
USER appuser
EXPOSE 8000

HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request,os; urllib.request.urlopen('http://127.0.0.1:%s/health' % os.getenv('PORT','8000'))"

CMD ["sh", "-c", "gunicorn --chdir app --bind 0.0.0.0:${PORT} --workers 2 main:app"]
