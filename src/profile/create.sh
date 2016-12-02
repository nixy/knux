profile_create()
{
  packages="nix"
  if [ "$(uname -s).$(uname -m)" = "Darwin.x86_64" ]; then
    packages="${packages} nss-cacert" # Add SSL certs for Darwin
  fi

  if [ -n "${1}" ] \
  && [ ! -d /nix/var/nix/profiles/"${1}" ]; then
    echo "creating profile ${1}"
    nix-env -i ${packages} -p /nix/var/nix/profiles/"${1}" 2> /dev/null
  fi
  unset packages
}
