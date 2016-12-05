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
