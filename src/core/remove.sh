# Removes packages from the current profile.
# Arguments: A list of package names to remove. If no package names are given,
#            then no packages are removed.
# Effects:   Removes packages from the current profile while leaving them
#            intact in the Nix store.
# Returns:   Confirmation of package removal.
remove()
{
  if [ -t 0 ]; then
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
