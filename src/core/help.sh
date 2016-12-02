help()
{
  cat << EOF
usage: nixy command [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list - list packages based on package names

  install - installs a package into the store and the current profile
  remove  - removes a package from the current profile  

  update  - fetch the latest nix expression updating the list of packages
  upgrade - installs newer versions of packages into the current profile

  garbage-collect - removes old packages no longer referenced by active profiles
EOF
  exit 0
}
