# Deletes a generation of the current profile
# All input validation is handled by $(nix-env --delete-generations)
# Arguments: The number of the generation to delete.
# Returns:   A message confirming the deletion.
generation_delete()
{
  nix-env --delete-generations "$@"
}
