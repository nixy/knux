help="usage: nixy command [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list - list packages based on package names

  install - installs a package into the store and the current profile
  remove  - removes a package from the current profile  

  update  - fetch the latest nix expression updating the list of packages
  upgrade - installs newer versions of packages into the current profile

  garbage-collect - removes old packages no longer referenced by active profiles
"

modules="$modules core"
commands="$commands
          list
	  search->list
	  install
	  remove
	  update
	  upgrade
	  garbage-collect->garbage_collect
	  help"
default_command="help"

help()
{
  echo "${help}"
  exit 0
}

# Searches packages using basic regular expressions.
# Arguments: A list of basic regular expressions to search package names with.
# Effects:   None
# Returns:   A list of package names that matched the regular expression.
list()
{
  if [ -t 1 ]; then
    echo "listing..." >&2
  fi
  PAGER="" nix-env -qa "${@}";
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
  if [ -t 1 ]; then
    echo "searching..." >&2
  fi

  if [ ${#} -gt 0 ]; then
    nix-env -Qi "${@}"
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
  if [ -t 1 ]; then
    echo "searching..." >&2
  fi

  #TODO
  if [ ${#} -gt 0 ]; then
    output=$(nix-env -e "${@}" 2>&1)
    if [ -n "${output}" ] && [ "${output}" != "(dry run; not doing anything)" ]; then
      echo "${output}"
    else
      if [ "${output}" = "(dry run; not doing anything)" ];then
	echo "${output}" >&2
      fi
      echo -e '\033[1;31merror:\033[0m no matches found'
      exit 1
    fi
  fi
}

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

# Upgrades packages in the current profile.
# Arguments: A list of package names to upgrade. If no package names are given,
#            then upgrade all packages in the current profile.
# Effects:   Install the upgraded package in the nix store and replaces the
#            package in the current profile.
# Returns:
upgrade()
{
  if [ -t 1 ]; then
    echo "searching..." >&2
  fi

  if [ ${#} -gt 0 ]; then
    nix-env -Qu "${@}" 
  else
    nix-env -Qu
  fi
}

# Removes packages with no active references in any generation or profile.
# Arguments: A list of package names to upgrade. If no package names are given,
#            then upgrade all packages in the current profile.
# Effects:   Purges packages with no active references to them. Depending on the
#            flags provided this may also remove old generations before purging
#            packages.
# Returns:   Progress information on the purge  and confirmation of package
#            deletion.
garbage_collect()
{
  nix-collect-garbage "$@"
}

