#!/usr/bin/env bash

set -e
[[ -n "${DEBUG}" ]] && set -x

set_key() {
  /usr/bin/ssh-add -D

  lpass show --notes 'ProductivityTools/id_rsa' | SSH_ASKPASS=/usr/local/bin/ssh-askpass /usr/bin/ssh-add -t 3H -
}

main() {

  local email="bgadelhahammarlund@pivotal.io"

  if ! [[ $(lpass status) =~ $email ]]; then
    lpass login "${email}"
  fi
  set_key
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
