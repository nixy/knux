modules="$modules extra"
commands="$commands profile generation"

shopt -s extglob

#TODO
profile()
{
  commands="list->profile_list
            create->profile_create
	    delete->profile_delete
	    switch->profile_switch"
  flags=""
  default_command="profile_help"
  process "$@"
}

profile_help()
{
cat << EOF
usage: nixy profile (lsit|create|delete|switch) [options]... [argument]

These are some common Nix commands used to manipulate user profiles:


EOF
}

profile_list()
{
  # if [ "${#}" -gt 0 ]; then
  #   echo -e "\e[1;31merror:\e[0m no arguments expected"
  #   exit 1
  # fi
  
  for profile in /nix/var/nix/profiles/*; do
    profile=$(basename "${profile}")
    if [ "${profile}" != "per-user" ] && [ "${profile}" != "system" ]; then
      # Ignore profile generations
      if grep -qv '\-[0-9]*-link' <<< $profile; then
	echo " "${profile}
      fi
    fi
  done; unset profile

  for profile in /nix/var/nix/profiles/per-user/"${USER}"/*; do
    profile=$(basename "${profile}")
    if grep -qv '\-[0-9]*-link' <<< $profile; then
      echo " "${profile}
    fi
  done; unset profile
}

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

  # Input validation. Don't delete the default or current profile.
  if [ "${1}" != "default" ] \
  && [ "${1}" != "${current}" ] \
  && [ -n "${1}" ] \
  && [ -d /nix/var/nix/profiles/"${1}" ]; then
    echo "deleting profile ${1}"
    rm -rf /nix/var/nix/profiles/"${1}"{,-*([0-9])-link}
  fi
}

profile_switch()
{
  current=$(basename $(readlink ~/.nix-profile))

  if [ -n "${1}" ] \
  && [ "${1}" != "${current}" ] \
  && [ -d /nix/var/nix/profiles/"${1}" ]; then
    echo "switching profiles from ${current} to ${1}"
    nix-env --switch-profile /nix/var/nix/profiles/"${1}"
  fi
  unset current
}


# Modules
#   Profiles
#   Generations
#   Store
#   Development


# Managing profiles
#   list-profiles   List available profiles
#   switch-profile  Switch to a different profile
#   delete-profile  Delete a profile
#   create-profile  Create a new profile

# Managing generations
#   list-generations   List all generations of the current profile
#   switch-generation  Switch to another generation of the current profile
#   delete-generation  Delete a generation
#   rollback           Switch to the previous generation
#   garbage-collect    Removes packages that aren't used by any generation


generation()
{
  commands="list->generation_list
            rollback->generation_rollback
	    delete->generation_delete
	    switch->generation_switch"
  flags=""
  default_command="generation_help"
  process "$@"
}


# Lists all generations of the current profile
# All input validation is handled by $(nix-env --list-generations)
# Arguments: None
# Returns:   A listing of all generations of the current profile.
generation_list()
{
  nix-env --list-generations
}

# Switches to another generation of the current profile
# All input validation is handled by $(nix-env --switch-generations)
# Arguments: The number of the generation to switch to.
# Returns:   A message confirming the switch.
generation_switch()
{
  nix-env --switch-generation "$@"
}

# Deletes a generation of the current profile
# All input validation is handled by $(nix-env --delete-generations)
# Arguments: The number of the generation to delete.
# Returns:   A message confirming the deletion.
generation_delete()
{
  nix-env --delete-generations "$@"
}

# Switches to previous generation of the current profile
# Arguments: None
# Returns:   A message confirming the switch.
generation_rollback()
{
  nix-env --rollback
}


      # list-profiles) list_profiles "$@";;
      # create-profile) create_profile "$@";;
      # delete-profile) delete_profile "$@";;
      # switch-profile) switch_profile "$@";;

      # list-generations) list_generations "$@";;
      # delete-generation) delete_generation "$@";;
      # switch-generation) switch_generation "$@";;
      # rollback) rollback_generation "$@";;
      # garbage-collect) garbage_collection "$@";;
      

