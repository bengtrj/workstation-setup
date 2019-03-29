#!/bin/bash

set -eu

main() {
  pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
  set_git_config
  echo "All done!"
}

set_git_config() {
  echo "Ensuring git configs are set up..."

  write_git_config_header

  ln -s "${PWD}/gitconfig-shared" "${HOME}/.gitconfig-shared"
}

write_git_config_header() {
if ! grep --quiet "path=${HOME}/.gitconfig-shared" "$HOME/.gitconfig"; then

cat << EOF >> "$HOME/.gitconfig"
[include]
  path=${HOME}/.gitconfig-shared
EOF

fi
}

main
