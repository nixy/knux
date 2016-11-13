is_valid_command()
{
  for valid_command in "${commands[@]}"; do
    if [ "$1" = "$valid_command" ]; then
      return 0
    fi
  done; unset valid_command
  return 1
}

is_valid_flag()
{
  for valid_flag in "${flags[@]}"; do
    if [ "$1" = "$valid_flag" ]; then
      return 0
    fi
  done; unset valid_flag
  return 1
}

process()
{
  declare command=""
  declare -a arguments=()

  if [ "$#" -eq 0 ]; then
    #TODO
    "${default_command:-:}"
    return
  fi

  for argument in "$@"; do
    if ! [ "$command" ] && is_valid_command "$argument"; then
      command="$argument"
    elif is_valid_flag "$argument"; then
      "$argument"
    else
      arguments+=("$argument")
    fi
  done; unset argument

  if [ "$command" ]; then
    "$command" "${arguments[@]}"
    return
  else
    #TODO
    "${default_command:-:}"
    return
  fi
}

process "$@"
