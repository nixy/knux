modules+=("profile")
commands+=("profile")

shopt -s extglob

profile()
{
  commands=("list->profile_list"
            "create->profile_create"
            "delete->profile_delete"
            "switch->profile_switch")
  flags=()
  default_command="profile_help"
  profproc "$@"
}

# Create a new Nix profile.
# Arguments: The name of the profile to create. If no name is given, then don't
#            create any profiles.
# Effects:   Create a new profile in the Nix store.
# Returns:
profile_create()
{
  packages="nix"
  if [ "$(uname -s).$(uname -m)" = "Darwin.x86_64" ]; then
    packages="${packages} nss-cacert" # Add SSL certs for Darwin
  fi

  if [ -n "${1}" ] \
  && [ ! -d /nix/var/nix/profiles/"${1}" ]; then
    echo "creating profile ${1}"
    nix-env -i ${packages} -p /nix/var/nix/profiles/"${1}" 2> /dev/null
  fi
  unset packages
}

profile_delete()
{
  current=$(basename $(readlink ~/.nix-profile))

  if [ "${1}" != "default" ] \
  && [ "${1}" != "${current}" ] \
  && [ -n "${1}" ] \
  && [ -d /nix/var/nix/profiles/"${1}" ]; then
    echo "deleting profile ${1}"
    rm -rf /nix/var/nix/profiles/"${1}"{,-*([0-9])-link}
  fi
}

profile_help()
{
  cat << EOF
usage: nixy profile (subcommand) [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list   - list profiles
  switch - switch the active nix profile

  create - create a new nix profile
  delete - delete a nix profile
EOF
  exit 0
}

profile_list()
{
  for profile in /nix/var/nix/profiles/*; do
    profile=$(basename "${profile}")
    if [ "${profile}" != "per-user" ] && [ "${profile}" != "system" ]; then
      # Ignore profile generations
      if grep -qv '\-[0-9]*-link' <<< $profile; then
	echo " "system/${profile}
      fi
    fi
  done; unset profile

  for profile in /nix/var/nix/profiles/per-user/"${USER}"/*; do
    profile=$(basename "${profile}")
    if grep -qv '\-[0-9]*-link' <<< $profile; then
      echo " "${USER}/${profile}
    fi
  done; unset profile
}

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
