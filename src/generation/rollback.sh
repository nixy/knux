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
