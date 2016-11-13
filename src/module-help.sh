modules+=("help")
commands+=("help")

helpstring="Usage: nixy [options] <command> [<arguments>]

These are common Nix commands used in various situations:

List packages (see also: nixy help query)
  list      List packages based on package name

Install packages (see also: nixy help install)
  install   Installs a package into the store and the current profile
  upgrade   Upgrades a package in the current profile

Remove packages (see also: nixy help remove)
  remove    Removes a package from the current profile

Updating repositories and packages:
  update    Updates list of available packages
"

help()
{
  echo "$helpstring"
}
