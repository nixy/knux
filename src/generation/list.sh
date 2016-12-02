# Lists all generations of the current profile
# All input validation is handled by $(nix-env --list-generations)
# Arguments: None
# Returns:   A listing of all generations of the current profile.
generation_list()
{
  nix-env --list-generations
}
