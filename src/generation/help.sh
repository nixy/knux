generation_help()
{
  cat << EOF
usage: nixy generation (subcommand) [options]... [arguments]...

CLI for the Nix package manager.

Basic commands:
  list - list generations of the current profile
  switch - switch the active generation of the current profile

  delete - delete a generation of the current profile

  rollback - return to the previous generation of the current profile
EOF
  exit 0
}
