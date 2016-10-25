#!/usr/bin/env bash

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




# List all the available profiles in the nix store.
# Arguments: None
# Returns:   A list of available profiles
list_profiles()
{
  if [ "$#" -gt 0 ]; then
	  echo -e "\e[1;31merror:\e[0m no arguments expected"
	  exit 1
  fi

  local profile

  for profile in /nix/var/nix/profiles/*; do
    profile=$(basename "${profile}")
    if [ "${profile}" != per-user ]; then
      # Ignore profile generations
      grep -v '\-[0-9]*-link' <<< $profile
    fi
  done
}

# Creates a new profile by installing the minimal set of packages to have a
# working nix environment.
# Arguments: The name of the profile to create
# Returns:   A message confirming the creation of the profile
create_profile()
{
  local packages="nix"
  if [ "$(uname -s).$(uname -m)" = "Darwin.x86_64" ]; then
    packages+=" nss-cacert" # Add SSL certs for Darwin
  fi

  if [ -n "$1" ] \
  && [ ! -d /nix/var/nix/profiles/"$1" ]; then
    echo "creating profile $1"
    nix-env -i ${packages} -p /nix/var/nix/profiles/"$1" 2> /dev/null
  fi
}

# Deletes a profile by deleting all generations of its profile in the nix store.
# Arguments: The name of the profile to delete
# Returns:   A message confirming the deletion of the profile
delete_profile()
{
  local current=$(basename $(readlink ~/.nix-profile))

  # Input validation. Don't delete the default or current profile.
  if [ "$1" != "default" ] \
  && [ "$1" != "${current}" ] \
  && [ -n "$1" ] \
  && [ -d /nix/var/nix/profiles/"$1" ]; then
    echo "deleting profile $1"
    rm -rf /nix/var/nix/profiles/"$1"{,-*([0-9])-link}
  fi
}

# Switches profiles
# Arguments: The name of the profile to switch to
# Returns:   A message confirming the profile switch
switch_profile()
{
  local current=$(basename $(readlink ~/.nix-profile))

  if [ -n "$1" ] \
  && [ "$1" != "${current}" ] \
  && [ -d /nix/var/nix/profiles/"$1" ]; then
    echo "switching profiles from ${current} to $1"
    nix-env --switch-profile /nix/var/nix/profiles/"$1"
  fi
}

# Lists all generations of the current profile
# All input validation is handled by $(nix-env --list-generations)
# Arguments: None
# Returns:   A listing of all generations of the current profile.
list_generations()
{
  nix-env --list-generations
}

# Switches to another generation of the current profile
# All input validation is handled by $(nix-env --switch-generations)
# Arguments: The number of the generation to switch to.
# Returns:   A message confirming the switch.
switch_generation()
{
  nix-env --switch-generation "$@"
}

# Deletes a generation of the current profile
# All input validation is handled by $(nix-env --delete-generations)
# Arguments: The number of the generation to delete.
# Returns:   A message confirming the deletion.
delete_generation()
{
  nix-env --delete-generations "$@"
}

# Switches to previous generation of the current profile
# Arguments: None
# Returns:   A message confirming the switch.
rollback_generation()
{
  nix-env --rollback
}

#{- garbage_collection -}#
# Removes all packages that aren't currently in any generations of a profile.
# Arguments: A list of arguments to pass to $(nix-collect-garbage) in no particular order.
# Returns:   The unmodified output of nix-collect-garbage
garbage_collection()
{
  nix-collect-garbage "$@"
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
      

