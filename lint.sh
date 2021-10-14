#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
ROOT_DIR="$(realpath --relative-to="$PWD" "$SCRIPT_DIR")"

function bash_shebang_present {
    [[ $(head -n 1 "$1" | tr -d "\n") == "#!/usr/bin/env bash" ]]
}
export -f bash_shebang_present

find "$ROOT_DIR" \
    \( \
        -name "*.sh" -o \
        -type f -a -exec bash -c 'bash_shebang_present "$0"' {} \; \
    \) \
    -print0 \
    | xargs -0t shellcheck
