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
