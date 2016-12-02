shopt -s extglob
profile_delete()
{
  current=$(basename $(readlink ~/.nix-profile))

  # Input validation. Don't delete the default or current profile.
  if [ "${1}" != "default" ] \
  && [ "${1}" != "${current}" ] \
  && [ -n "${1}" ] \
  && [ -d /nix/var/nix/profiles/"${1}" ]; then
    echo "deleting profile ${1}"
    rm -rf /nix/var/nix/profiles/"${1}"{,-*([0-9])-link}
  fi
}
