# DevOps Learning Lab

A hands-on repository for learning DevOps engineering. Each project is small, self-contained, and builds on the previous one. Work through them in order, break things on purpose, and write down what you learn.

| # | Project | Skills practised |
|---|---------|------------------|
| 01 | [Dockerized Flask app](01-docker-flask-app/) | Dockerfile, multi-stage builds, Docker Compose, health checks |
| 02 | [CI/CD with GitHub Actions](02-github-actions-ci/) | Pipelines, tests, linting, building and publishing images |
| 03 | [Kubernetes manifests](03-kubernetes/) | Deployments, Services, ConfigMaps, probes, autoscaling |
| 04 | [Terraform basics](04-terraform-aws/) | Infrastructure as code, variables, outputs, remote state |
| 05 | [Ansible server setup](05-ansible-nginx/) | Configuration management, idempotency, handlers, templates |
| 06 | [Monitoring with Prometheus and Grafana](06-monitoring/) | Metrics, scraping, dashboards, alert rules |
| 07 | [Bash automation scripts](07-bash-automation/) | Health checks, backups, safe scripting |

## How to use this repo

1. Push it to your own GitHub account (see [Getting it on GitHub](#getting-it-on-github)).
2. Read the README inside each project, then do the **Exercises** at the bottom.
3. Commit your changes as you go. A history of small, honest commits is the best proof of learning.

## Prerequisites

Install as you reach each project; you do not need everything on day one.

- Git and a GitHub account
- Docker and Docker Compose (projects 01, 02, 06)
- Python 3.11+ (projects 01, 02)
- kubectl plus a local cluster such as [kind](https://kind.sigs.k8s.io/) or minikube (project 03)
- Terraform 1.5+ and an AWS account (project 04; the free tier is enough)
- Ansible 2.14+ (project 05)

## Suggested learning path

- **Week 1:** Linux and Git basics, then project 01 and 07.
- **Week 2:** Project 02. Make the pipeline go green, then make it fail on purpose.
- **Week 3:** Project 03 on a local kind cluster.
- **Week 4:** Projects 04 and 05.
- **Week 5:** Project 06, then connect the monitoring stack to the app from project 01.

## Getting it on GitHub

1. Create an empty repository on GitHub (no README, no .gitignore) named `devops-learning-lab`.
2. From this folder:

```bash
git init
git add .
git commit -m "Initial commit: DevOps Learning Lab"
git branch -M main
git remote add origin https://github.com/<your-username>/devops-learning-lab.git
git push -u origin main
```

3. In the repo settings, open **Actions** and make sure workflows are allowed to run.
4. Replace `YOUR_GITHUB_USERNAME` in project 02's workflow notes and the Kubernetes image reference with your own username.

## Safety notes

- Never commit secrets. `.gitignore` already excludes `*.tfstate`, `*.tfvars`, `.env` and key files.
- Terraform resources can cost money. Run `terraform destroy` when you finish a session.
- All example credentials in this repo are placeholders for local practice only.

## License

MIT, see [LICENSE](LICENSE).
