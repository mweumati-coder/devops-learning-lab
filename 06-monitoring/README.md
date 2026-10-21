# 06 - Monitoring with Prometheus and Grafana

Runs the app from project 01 alongside Prometheus (metrics collection and alert rules) and Grafana (dashboards).

## What you will learn

- The pull-based metrics model
- Reading Prometheus config and writing PromQL
- Alert rules
- Provisioning Grafana data sources as code

## Run it

```bash
docker compose up --build -d
# generate some traffic
for i in $(seq 1 100); do curl -s localhost:8000/ > /dev/null; done
```

- App: http://localhost:8000
- Prometheus: http://localhost:9090 (try the queries below)
- Grafana: http://localhost:3000 (login `admin` / `admin`, local practice only)

## Starter PromQL

```promql
app_requests_total
rate(app_requests_total[1m])
app_uptime_seconds
up{job="lab-app"}
```

## Exercises

1. In Grafana, create a dashboard with a graph of `rate(app_requests_total[1m])` and a stat panel for uptime.
2. Run `docker compose stop app`, then watch `AppDown` move from pending to firing on the Prometheus **Alerts** page.
3. Export your dashboard as JSON, save it under `grafana/provisioning/dashboards/`, and provision it as code.
4. Add Alertmanager and route the alert to email or a Slack webhook.
5. Add a request latency histogram to the Flask app and graph the 95th percentile.
6. Add `node-exporter` to monitor the host machine itself.
