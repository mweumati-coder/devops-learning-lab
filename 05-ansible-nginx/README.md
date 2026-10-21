# 05 - Ansible server setup

Installs and configures nginx on Ubuntu/Debian servers using a playbook, templates and handlers.

## What you will learn

- Inventories and SSH-based automation
- Idempotency: running twice changes nothing the second time
- Templates (Jinja2) and variables
- Handlers that run only when something changed

## Get a target server

Any Ubuntu VM you can SSH into works: a cheap cloud instance, a local VM (VirtualBox, Multipass), or a Raspberry Pi.

## Run it

```bash
cp inventory.ini.example inventory.ini     # edit with your host details
ansible all -i inventory.ini -m ping
ansible-playbook -i inventory.ini playbook.yml --check --diff   # dry run
ansible-playbook -i inventory.ini playbook.yml
ansible-playbook -i inventory.ini playbook.yml                  # run again: expect changed=0
curl http://<server-ip>/
```

## Exercises

1. Run the playbook twice. Explain why the second run reports `changed=0`.
2. Override a variable: `-e site_message="Hello from my laptop"`. Confirm the handler reloads nginx.
3. Add a task that opens port 80 with `ufw`.
4. Move the tasks into a role with `ansible-galaxy init roles/nginx`.
5. Encrypt a secret with `ansible-vault` and use it in a template.
6. Lint with `ansible-lint playbook.yml` and fix what it reports.
