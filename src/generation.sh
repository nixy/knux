modules+=("generation")
commands+=("generation")

generation()
{
  commands=("delete->generation_delete"
            "help->generation_help"
            "list->generation_list"
            "rollback->generation_rollback"
            "switch->generation_switch")
  flags=()
  default_command="generation_help"
  profproc "$@"
}

# Deletes generations of the current profile
# Arguments: A list of the generation numbers to delete.
# Effects:   Removes the links for those generations from the Nix store, leaving their
#            installed data in the Nix store.
# Returns:   A message confirming the deletion.
generation_delete()
{
  if [ "${#}" -eq 0 ]; then
    echo -e "\033[1;31merror:\033[0m at least one argument expected"
  else
    nix-env --delete-generations "$@"
  fi
}

generation_help()
{
  cat << EOF
usage: nixy generation (subcommand) [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list - list generations of the current profile
  switch - switch the active generation of the current profile

  delete - delete a generation of the current profile

  rollback - return to the previous generation of the current profile
EOF
  exit 0
}

# Lists all generations of the current profile
# Arguments: None
# Effects:   None
# Returns:   A list of all generations of the current profile.
generation_list()
{
  if [ "${#}" -gt 0 ]; then
    echo -e "\033[1;31merror:\033[0m no arguments expected"
  else
    nix-env --list-generations
  fi
}

# Switches to previous generation of the current profile
# Arguments: None
# Effects:   Switches to the previous generation, relative to the current
#            generation, of the current profile.
# Returns:   A message confirming the switch.
generation_rollback()
{
  if [ "${#}" -gt 0 ]; then
    echo -e "\033[1;31merror:\033[0m no arguments expected"
  else
    nix-env --rollback
  fi
}

# Switches to a generation of the current profile
# Arguments: The generation number to switch to.
# Effect:    Switches to the specified generation of the current profile.
# Returns:   A message confirming the switch.
generation_switch()
{
  if [ "${#}" -ne 1 ]; then
    echo -e "\033[1;31merror:\033[0m exactly one arguments expected"
  else
    nix-env --switch-generation "$@"
  fi
}
