#!/usr/bin/env bash
# =============================================================================
# common.sh
# Shared helper functions sourced by every check script in this toolkit.
# Not meant to be executed directly.
# =============================================================================

set -uo pipefail

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${LIB_DIR}/../.." && pwd)"
CONFIG_FILE="${PROJECT_ROOT}/config/health_check.conf"

if [[ -f "${CONFIG_FILE}" ]]; then
    # shellcheck disable=SC1090
    source "${CONFIG_FILE}"
else
    echo "ERROR: config file not found at ${CONFIG_FILE}" >&2
    exit 1
fi

mkdir -p "${LOG_DIR}" "${DATA_DIR}" "${REPORT_DIR}"

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
DATE_ONLY="$(date '+%Y-%m-%d')"
HOSTNAME_STR="$(hostname)"

# log_line <LEVEL> <message...>
# Writes a timestamped line to stdout and to logs/health_check.log
log_line() {
    local level="$1"; shift
    local message="$*"
    echo "[${TIMESTAMP}] [${level}] ${message}" | tee -a "${LOG_DIR}/health_check.log"
}

# json_escape <string>
# Escapes backslashes and double quotes so a string is safe to embed in JSON.
json_escape() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    printf '%s' "$s"
}

# write_result <data_file_basename> <json_line>
# Appends one JSON line to logs/data/<data_file_basename> for later
# consumption by python/generate_report.py
write_result() {
    local file="$1"
    local json="$2"
    echo "${json}" >> "${DATA_DIR}/${file}"
}
