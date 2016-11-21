modules="${modules} python"
commands="${commands} python python2 python3"

python()
{
  python2 "${@}"
}

python2()
{
  commands="list->python2_list
            shell->python2_shell"
  flags=""
  default_commands=""
  process "${@}"
}

python3()
{
  commands="list->python3_list
            shell->python3_shell"
  flags=""
  default_command=""
  process "${@}"
}

python_list()
{
  python_version="${1}"; shift
  list -f "<nixpkgs>" -A "${python_version}" "$@"
  unset python_version
}

python2_list()
{
  python_list "python2Packages" "${@}"
}

python3_list()
{
  python_list "python3Packages" "${@}"
}

python_shell()
{
  python_version="${1}"; shift

  #TODO: Sloppy but POSIX
  for arg in "${@}"; do
    args="${python_version}.${arg} ${args}"
  done; unset arg

  nix-shell --run "python3" -p $args
  unset args python_version
}

python2_shell()
{
  python_shell "python2Packages" "${@}"
}

python3_shell()
{
  python_shell "python2Packages" "${@}"
}
