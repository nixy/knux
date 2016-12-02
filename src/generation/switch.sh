# Switches to another generation of the current profile
# All input validation is handled by $(nix-env --switch-generations)
# Arguments: The number of the generation to switch to.
# Returns:   A message confirming the switch.
generation_switch()
{
  nix-env --switch-generation "$@"
}
