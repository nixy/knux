# Switches to previous generation of the current profile
# Arguments: None
# Returns:   A message confirming the switch.
generation_rollback()
{
  nix-env --rollback
}
