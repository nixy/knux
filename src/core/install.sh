# Install packages into the current profile.
# Arguments: A list of package names to install. If no package names are given,
#            then no packages are installed.
# Effects:   Installs the packages into the Nix store and adds them to the
#            current profile.
# Returns:   Progress information on the installation and confirmation of
#            package installation.
install()
{
  if [ -t 0 ]; then
    echo "searching..." >&2
  fi

  if [ ${#} -gt 0 ]; then
    nix-env -Qi "${@}"
  fi
}
