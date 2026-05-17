#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"

deny_patterns=(
  "rm -rf /"
  "sudo rm"
  "chmod -R 777"
  "docker volume prune"
  "kubectl delete"
  "terraform destroy"
  "db reset"
  "drop database"
)

secret_patterns=(
  ".env"
  "id_rsa"
  "credentials.json"
  "secrets/"
)

for pattern in "${deny_patterns[@]}"; do
  if printf '%s' "$payload" | grep -Eiq "$pattern"; then
    echo "Blocked risky command pattern: $pattern" >&2
    exit 2
  fi
done

for pattern in "${secret_patterns[@]}"; do
  if printf '%s' "$payload" | grep -Eiq "$pattern"; then
    echo "Blocked possible secret access pattern: $pattern" >&2
    exit 2
  fi
done

exit 0
