#!/usr/bin/env bash
# =============================================================================
# install.sh
# One-time setup: makes scripts executable, creates required directories,
# and (optionally) installs the daily cron job.
# =============================================================================

set -euo pipefail
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting executable permissions on scripts..."
chmod +x "${PROJECT_ROOT}"/scripts/*.sh
chmod +x "${PROJECT_ROOT}"/scripts/lib/*.sh 2>/dev/null || true

echo "Creating logs and reports directories..."
mkdir -p "${PROJECT_ROOT}/logs/data" "${PROJECT_ROOT}/reports"

echo "Checking for python3..."
if ! command -v python3 &>/dev/null; then
    echo "WARNING: python3 not found. Install it to enable report generation."
fi

read -r -p "Install a daily cron job at 07:00 for this toolkit? [y/N] " answer
if [[ "${answer,,}" == "y" ]]; then
    CRON_CMD="0 7 * * * ${PROJECT_ROOT}/scripts/run_all_checks.sh >> ${PROJECT_ROOT}/logs/cron.log 2>&1"
    ( crontab -l 2>/dev/null | grep -vF "run_all_checks.sh" ; echo "${CRON_CMD}" ) | crontab -
    echo "Cron job installed:"
    echo "  ${CRON_CMD}"
else
    echo "Skipped cron install. See cron/crontab_example.txt to add it manually."
fi

echo "Setup complete. Run ${PROJECT_ROOT}/scripts/run_all_checks.sh to test it."
