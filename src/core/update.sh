# Updates the list of available packages.
# Arguments: A list of nix-channels to update. If no channels are given, then
#            all channels are updated.
# Effects:   None
# Returns:   Information on the nix expression being downloaded.
update()
{
  if [ ${#} -gt 0 ]; then
    nix-channel --update "${@}" 
  else
    nix-channel --update
  fi
}
