# justfile
set shell := ["bash", "-c"]

# Install dependencies
install:
    ansible-galaxy install -r requirements.yml
    pip install -r requirements.txt

# Deploy to production
deploy-prod:
    ansible-playbook -i inventories/production site.yml --ask-vault-pass

# Deploy to staging  
deploy-staging:
    ansible-playbook -i inventories/staging site.yml

# Run syntax check
check:
    ansible-playbook site.yml --syntax-check

# Run dry-run
dry-run env="staging":
    ansible-playbook -i inventories/{{env}} site.yml --check --diff

# Lint playbooks
lint:
    ansible-lint .
    yamllint .

# Encrypt vault file
encrypt-vault file:
    ansible-vault encrypt {{file}}

# Edit vault file
edit-vault file:
    ansible-vault edit {{file}}