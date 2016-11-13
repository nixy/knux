modules+=("core")
commands+=("list" "search" "install" "remove" "update" "upgrade")
flags+=("--version")

version="0.0.1"
--version()
{
  echo "nixy $version"
  echo "supported modules: "
  for module in "${modules[@]}"; do
    echo "* $module"
  done
  exit 0
}

# Searches packages using basic regular expressions.
# Arguments: A list of basic regular expressions to search package names with.
# Effects:   None
# Returns:   A list of package names that matched the regular expression.
list()
{
  echo "Listing..."
  PAGER="" nix-env -qa "$@";
}

# Install packages into the current profile.
# Arguments: A list of package names to install. If no package names are given,
#            then no packages are installed.
# Effects:   Installs the packages into the Nix store and adds them to the
#            current profile.
# Returns:   Progress information on the installation and confirmation of
#            package installation.
install()
{
  if [ $# -gt 0 ]; then
    nix-env -Qi "$@"
  fi
}

# Removes packages from the current profile.
# Arguments: A list of package names to remove. If no package names are given,
#            then no packages are removed.
# Effects:   Removes packages from the current profile while leaving them
#            intact in the Nix store.
# Returns:   Confirmation of package removal.
remove()
{
  if [ $# -gt 0 ]; then
    nix-env -e "$@"
  fi
}

# Updates the list of available packages.
# Arguments: A list of nix-channels to update. If no channels are given, then
#            all channels are updated.
# Effects:   None
# Returns:   Information on the nix expression being downloaded.
update()
{
  if [ $# -gt 0 ]; then
    nix-channel --update "$@" 
  else
    nix-channel --update
  fi
}

# Upgrades packages in the current profile.
# Arguments: A list of package names to upgrade. If no package names are given,
#            then upgrade all packages in the current profile.
# Effects:   Install the upgraded package in the nix store and replaces the
#            package in the current profile.
# Returns:
upgrade()
{
  if [ $# -gt 0 ]; then
    nix-env -Qu "$@" 
  else
    nix-env -Qu
  fi
}
