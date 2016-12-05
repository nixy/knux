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
