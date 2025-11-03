# Project Documentation — ACM‑Aligned Template

Instructor:  
Version: 2025 Fall  
License: MIT

Outcome & Rubric Crosswalk (Checklist)  
Use this to ensure your documentation and artifacts demonstrate each outcome and satisfy the rubric. Mark each ☐ when complete.

| Outcome | Where It Appears | External Evidence | Status |
|---|---:|---|:---:|
| O1 | §2 Problem & Requirements; §3 System Overview | Appendix A (Operational Requirements), Backlog, User Stories | ☐ |
| O2 | §3 System Overview & Architecture; §5 Implementation Notes | Repo structure, Code, CI status badge | ☐ |
| O3 | §6 Testing & Evaluation | Test reports, smoke-validation logs, performance dashboards | ☐ |
| O4 | §1 Executive Summary; §9 Limitations & Future Work | Runbooks, Change logs, Deployment notes | ☐ |
| O5 | §7 Security/Privacy/Compliance | Threat model / Model card / SBOM / Access control logs | ☐ |
| O6 | §4 Discipline‑Specific Depth | CI/CD, IaC, observability artifacts | ☐ |

1. Executive Summary  
AutomatedDevBuilder is a lightweight toolkit for IT teams to provision reproducible developer environments across workstations and internal VMs. It provides a presets-based generator for docker-compose configurations, an interactive launcher for common operational tasks (build, start, stop, tail logs), example service images (Python, Node) and a Postgres sample with initialization scripts, plus an optional Ansible helper to prepare fresh Ubuntu hosts. Primary beneficiaries are IT staff and platform engineers responsible for onboarding new employees, maintaining internal sandbox environments, and ensuring consistent developer workstations. The project emphasizes operational repeatability, quick recovery, and low-friction distribution for internal teams. Early smoke tests show presets generate valid compose files and sample services start on expected ports (placeholders: insert measured startup times and success rates).

2. Problem & Requirements (O1)  
Context and stakeholders  
- Stakeholders: IT operations staff, developer platform engineers, team leads, internal developers.
- Primary problem: IT needs a reproducible, low‑effort way to provision development and sandbox environments for employees, reduce "works on my machine" issues, and accelerate onboarding.
- Secondary problems: provide fast repro environments for incident triage, create disposable sandboxes for experiments, and provide documented runbooks for operations staff.

Personas  
- IT Platform Engineer: builds and maintains reproducible environment presets, integrates them into CI/CD pipelines, and provides support runbooks.
- IT Operations / Sysadmin: deploys environments to internal VMs, runs Ansible on bare images, and troubleshoots issues during onboarding.
- Developer (internal): needs consistent local or VM environments matching internal services to develop and test features without complex local installs.

Functional requirements  
- R1: Presets that generate valid docker-compose.yml files for common operational stacks (dev-workstation, api-sandbox, db-only).
- R2: Interactive launcher to build and start services in detached mode and to run common maintenance tasks (logs, backups, restores).
- R3: Sample apps and DB init scripts so environments are runnable immediately for onboarding and troubleshooting.
- R4: Ansible playbook to automate Docker installation and basic configuration on fresh Ubuntu hosts used by IT.

Non-functional requirements  
- N1: Reproducibility — identical presets produce consistent environments across hosts.
- N2: Operability — provide clear runbooks and health checks for IT staff.
- N3: Security posture — avoid embedding secrets; provide guidance for secrets management for production-like development.
- N4: Performance — reasonable startup times for typical developer workstations (goal < 60s for service availability after compose up for lightweight presets).

Constraints and risks  
- Constraint: relies on Docker and Docker Compose plugin being available on host.
- Risk: long image builds may exceed CI runner quotas; mitigate with smoke-validation and cached layers in CI.
- Risk: exposing internal services incorrectly — mitigated by documented firewall and access guidance in the Admin runbook.

Success criteria  
- SC1: Preset generation passes docker compose config for each operational preset.
- SC2: Key services respond to health checks within configured timeouts (e.g., HTTP 200 on default endpoints within 60s).
- SC3: IT staff can provision a working developer environment from a clean Ubuntu VM using the Ansible helper and scripts within documented time (target: 10 minutes for install + generate + start).

Prioritized backlog (top items)  
1. Push current docs and open docs PR (done)  
2. Add GitHub Actions smoke-validation workflow (shellcheck + docker compose config)  
3. Add operational healthchecks and backup/restore runbook for Postgres  
4. Improve start.sh with operational subcommands and enhanced logging  
5. Add a dev-workstation preset that includes common internal services and optional codeserver  
6. Integrate presets with internal config management (e.g., Ansible roles or CI artifacts)  
7. Add automated SBOM generation for sample images and CI vulnerability scanning  
8. Add test harness for generate-compose.sh  
9. Add onboarding guide for IT staff (runbook + checklist)  
10. Create an image packaging flow for VM snapshots used during onboarding  

(Full backlog / board: PLACEHOLDER — insert link to your team backlog)

3. System Overview & Architecture (O2)  
Architecture summary  
- Launcher (start.sh): interactive menu for preset selection and operational actions (build, start, stop, logs, backup/restore).  
- Generator (generate-compose.sh): composes services from profiles/*.yml into a single docker-compose.yml suitable for local or VM usage.  
- Services: sample python-app (port 8000), sample node-app (port 3000), Postgres (5432) with initialization scripts for deterministic demo data.  
- Ansible helper (ansible/install-docker.yml): installs Docker and configures the host for non-root Docker usage on Ubuntu.

Diagram  
- Insert architecture diagram here (C4 container view). Replace with project diagram file: ![architecture](docs/architecture.png)

Key technologies  
- Docker / Docker Compose plugin  
- Bash scripts (start.sh, generate-compose.sh)  
- Postgres for data persistence (docker/postgres/init.sql)  
- Ansible (for Ubuntu host prep)  
- Minimal sample apps (Node and Python) used for operational validation

API & data overview  
- Prototype services expose simple HTTP endpoints used by IT for smoke checks and validation.  
- Postgres contains demo data seeded by init scripts; backup/restore commands are documented in Appendix C.

4. Discipline‑Specific Depth (O6)  
Architecture & Integration  
- Network topology: docker-compose sets up an isolated network per project; host port mappings for developer access.
- Platform choices: Docker Compose chosen for portability across developer workstations and VMs; Ansible used for repeatable host setup.

DevOps & SRE  
- CI: planned GitHub Actions smoke-validation job (shellcheck + presets generation + docker compose config).  
- IaC: Ansible role to configure Ubuntu hosts (idempotent).  
- Observability: recommend adding health endpoints and centralized logging for production-like testing; currently rely on docker compose logs.  
- SLOs/SLIs: propose SLI = environment ready (services up & responding) within 60s; SLO = 95% success during onboarding windows. (Adjust numbers after pilot runs.)

Operations & Security  
- Access management: document firewall rules and recommend VPN/internal network usage for sensitive services.
- Backup/restore: provide pg_dump/pg_restore examples and include runbook steps for IT to create periodic backups of demo data.
- Change management: use PRs + smoke-validation and code review to manage presets and scripts.

5. Implementation Notes (O2)  
Repository structure (highlight)  
- generate-compose.sh — compose generator and preset loader (profiles/*.yml)  
- start.sh — interactive launcher with operational subcommands  
- profiles/ — presets oriented for IT use (dev-workstation, api-sandbox, db-only)  
- docker/ — Dockerfiles (docker/node, docker/python, docker/postgres)  
- src-node/, src/ — sample app source code  
- ansible/ — install-docker.yml and README for host prep  
- docs/ — architecture, runbooks, and academic docs

Coding conventions & tradeoffs  
- Implementation uses Bash for portability and minimal runtime dependencies. Tradeoff: complex logic can be harder to test than code in a higher-level language, but Bash reduces setup friction for IT workflows.  
- Presets are YAML fragments merged by the generator; this keeps the presets readable for IT staff but is intentionally simple—consider templating (yq/jinja2) if complexity grows.

Notable patterns  
- Operational focus: presets include runbook metadata and recommended post-start validation commands (healthcheck endpoints, backup steps).  
- Defensive scripting: generator validates presence of provided presets and prints clear, actionable errors for IT operators.

6. Testing & Evaluation (O3)  
Testing strategy  
- Unit: future work to add unit tests if generator logic migrates from Bash to a language with test frameworks.  
- Integration / smoke: immediate checks include shellcheck, generate-compose.sh run, docker compose config, and optional docker compose up -d for a lightweight preset.  
- Operational validation: run a time-to-ready test on a fresh VM using Ansible + generate/start and log timings and any errors.

Concrete smoke checks (examples)  
- shellcheck generate-compose.sh start.sh  
- ./generate-compose.sh --preset dev-workstation  
- docker compose config  
- docker compose up -d  
- curl --max-time 10 http://localhost:3000  
- curl --max-time 10 http://localhost:8000  
- pg_isready -h localhost -p 5432

Metrics to collect  
- Time to generate compose file  
- Time to service readiness after docker compose up  
- Failure rates during onboarding runs  
- CI job run durations (for smoke-validation)

Defect summary (placeholder)  
- Track defects found during pilot runs here (e.g., port conflicts, missing permissions). Insert table of defects and status.

7. Security, Privacy, Accessibility & Compliance (O5)  
Security considerations  
- Do not embed secrets in presets. Provide .env.example and instructions for secure secret storage (vaults, environment variables).
- SBOM and vulnerability scans: add Trivy or Syft scans in CI to create SBOMs and identify high-severity findings before wider distribution.

Privacy, ethics & legal  
- Use synthetic or sanitized data for demo datasets distributed by IT. Ensure data-handling documentation is present if realistic data is required.

Accessibility  
- Documentation should be accessible (text alternatives for images, transcripts for videos).  
- Runbooks and onboarding checklists should use clear, sequenced steps to lower cognitive load for on-call staff.

Compliance  
- Recommend IT review for internal policies (data handling, internal network exposure) before distributing presets across the company network.

8. Deployment & Operations  
How to deploy  
- Local dev or VM: use start.sh or generate-compose.sh + docker compose up -d (see USAGE.md).  
- Fresh VM provisioning: run ansible/install-docker.yml, clone repo, and run the documented generate/start commands.  
- Onboarding flow: IT runs the Ansible playbook, generates the dev-workstation preset, and hands the prepared VM or snapshot to the new developer.

Runbook pointers (Appendix C)  
- Start: ./start.sh → choose preset → build → start  
- Stop and cleanup: docker compose down  
- Backup Postgres: docker compose exec postgres pg_dump -U dev -d devdb > backup.sql  
- Restore Postgres: docker compose exec -T postgres psql -U dev -d devdb < backup.sql  
- Health-check example: curl --max-time 5 http://localhost:3000/health

9. Limitations & Future Work  
Known limitations  
- Prototype is intended for operational demos and onboarding; not hardened for production workloads.  
- Some presets may require local network adjustments (firewalls, VPN) for internal-only services.  
- Secret management and persistent backup workflows are not yet implemented.

Prioritized future work  
- Add CI smoke jobs and nightly integration runs with caching.  
- Add SBOM generation and vulnerability scanning in CI.  
- Provide an Ansible role to integrate generated compose files into VM image build pipelines.  
- Improve generator to support templating and environment-specific overrides.

10. References  
- Docker Compose V2 documentation: https://docs.docker.com/compose/  
- Ansible docs: https://docs.ansible.com/  
- Internal runbook templates and change-management policies: PLACEHOLDER (link internal docs)

Appendices (Evidence & How‑To)  
A. Installation Guide — see INSTALL.md  
B. User Manual — see USAGE.md (operational workflows)  
C. Admin/Operations Guide — include runbook snippets and on-call notes (to be expanded)  
D. API Reference — none in prototype; add OpenAPI if services gain APIs  
E. Runbook / Onboarding checklist — add links to templates and VM snapshot playbooks  
F. Evidence Index — links to smoke-validation logs, CI runs, pilot onboarding notes

---  
Notes  
- I updated the document focus from an academic/student audience to IT staff / operational onboarding workflows. Replace placeholders with internal backlog links, measured metrics from pilot runs, and your architecture diagram (docs/architecture.png) to complete the record.