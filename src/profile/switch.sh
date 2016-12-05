profile_switch()
{
  current=$(basename $(readlink ~/.nix-profile))

  if [ -n "${1}" ] \
  && [ "${1}" != "${current}" ]; then
    echo "switching profiles from ${current} to ${1}"
    if [ -d "/nix/var/nix/profiles/${1}" ]; then
      nix-env --switch-profile /nix/var/nix/profiles/"${1}"
    elif [ -d "/nix/var/nix/profiles/per-user/${1}" ]; then
      nix-env --switch-profile /nix/var/nix/profiles/per-user/"${1}"
    fi
  fi

  unset current
}
