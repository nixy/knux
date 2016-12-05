profile_help()
{
  cat << EOF
usage: nixy profile (subcommand) [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list   - list profiles
  switch - switch the active nix profile

  create - create a new nix profile
  delete - delete a nix profile
EOF
  exit 0
}
