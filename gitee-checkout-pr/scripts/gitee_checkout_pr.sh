#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: gitee_checkout_pr.sh <pr_number> [branch_name]

Fetch a Gitee pull request from the current git repository and switch to it.

Arguments:
  pr_number    Numeric Gitee pull request ID
  branch_name  Optional local branch name (default: pr_<pr_number>)

Environment:
  GITEE_REMOTE Override auto-detected remote name when multiple Gitee remotes exist
EOF
}

die() {
    echo "Error: $*" >&2
    exit 1
}

get_remote_url() {
    local remote=$1
    git config --get "remote.${remote}.url" 2>/dev/null || true
}

is_gitee_url() {
    local url=$1
    [[ "$url" =~ (^|[@/:])gitee\.com([/:]|$) ]]
}

detect_gitee_remote() {
    local override=${GITEE_REMOTE:-}
    local remote
    local url

    if [[ -n "$override" ]]; then
        url=$(get_remote_url "$override")
        [[ -n "$url" ]] || die "Remote '$override' does not exist."
        is_gitee_url "$url" || die "Remote '$override' does not point to Gitee: $url"
        printf '%s\n' "$override"
        return
    fi

    remote=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null | cut -d/ -f1 || true)
    if [[ -n "$remote" ]]; then
        url=$(get_remote_url "$remote")
        if [[ -n "$url" ]] && is_gitee_url "$url"; then
            printf '%s\n' "$remote"
            return
        fi
    fi

    url=$(get_remote_url origin)
    if [[ -n "$url" ]] && is_gitee_url "$url"; then
        printf '%s\n' origin
        return
    fi

    local -a matches=()
    while IFS= read -r remote; do
        [[ -z "$remote" ]] && continue
        url=$(get_remote_url "$remote")
        if [[ -n "$url" ]] && is_gitee_url "$url"; then
            matches+=("$remote")
        fi
    done < <(git remote)

    case "${#matches[@]}" in
        1)
            printf '%s\n' "${matches[0]}"
            ;;
        0)
            die "No Gitee remote found in this repository."
            ;;
        *)
            die "Multiple Gitee remotes found (${matches[*]}). Set GITEE_REMOTE=<remote-name>."
            ;;
    esac
}

main() {
    if [[ ${1:-} == "-h" || ${1:-} == "--help" ]]; then
        usage
        exit 0
    fi

    [[ $# -ge 1 && $# -le 2 ]] || {
        usage >&2
        exit 1
    }

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Run this script inside a git work tree."

    local pr_number=$1
    local branch_name=${2:-pr_${pr_number}}
    local remote

    [[ "$pr_number" =~ ^[0-9]+$ ]] || die "PR number must be numeric."

    remote=$(detect_gitee_remote)

    echo "Using Gitee remote: ${remote}"
    echo "Fetching PR #${pr_number}..."
    git fetch "$remote" "pull/${pr_number}/head"
    echo "Switching to branch ${branch_name}..."
    git switch -C "$branch_name" FETCH_HEAD
    echo "Checked out PR #${pr_number} into ${branch_name}"
}

main "$@"
