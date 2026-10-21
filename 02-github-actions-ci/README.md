# 02 - CI/CD with GitHub Actions

GitHub only runs workflows stored in `.github/workflows/` at the **repository root**, so the working pipeline for this project lives at [`../.github/workflows/ci.yml`](../.github/workflows/ci.yml). This folder holds the notes and exercises.

## What the pipeline does

1. **test job** - installs dependencies (with pip caching), lints with flake8, runs pytest.
2. **docker job** - runs only on pushes to `main` and only if tests pass. It builds the image from project 01 and pushes it to GitHub Container Registry (`ghcr.io/<you>/lab-app`) tagged with the commit SHA and `latest`.

Pull requests run tests but never publish an image.

## Try it

1. Push the repo to GitHub.
2. Open the **Actions** tab and watch the first run.
3. After a green run on `main`, open your profile, then **Packages**, and find `lab-app`.
4. Pull it: `docker pull ghcr.io/<your-username>/lab-app:latest`

## Key ideas

- `permissions:` follows least privilege. The test job can only read the repo.
- `needs:` creates a dependency between jobs.
- `if:` gates the publish step so unreviewed code is never released.
- `GITHUB_TOKEN` is created per run, so you never store a registry password.
- `paths:` filters avoid running the pipeline when unrelated files change.

## Exercises

1. Break a test on a branch, open a pull request, and watch the check fail. Fix it and watch it pass.
2. Add a `Trivy` or `hadolint` step that scans the Dockerfile.
3. Add a matrix to test on Python 3.11 and 3.12.
4. Protect `main` (Settings, Branches) and require the `Lint and test` check before merging.
5. Add a second workflow that deploys to your Kubernetes cluster (see project 03) after the image is pushed.
