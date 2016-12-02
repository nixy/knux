# Upgrades packages in the current profile.
# Arguments: A list of package names to upgrade. If no package names are given,
#            then upgrade all packages in the current profile.
# Effects:   Install the upgraded package in the nix store and replaces the
#            package in the current profile.
# Returns:
upgrade()
{
  if [ -t 0 ]; then
    echo "searching..." >&2
  fi

  if [ ${#} -gt 0 ]; then
    nix-env -Qu "${@}" 
  else
    nix-env -Qu
  fi
}
