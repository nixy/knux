is_valid_command()
{
  for valid_command in ${commands}; do
    if [ "${1}" = "${valid_command%->*}" ]; then
      echo "${valid_command#*->}"
      return 0
    fi
  done; unset valid_command
  return 1
}

is_valid_flag()
{
  for valid_flag in ${flags}; do
    if [ "${1}" = "${valid_flag%->*}" ]; then
      echo "${valid_flag#*->}"
      return 0
    fi
  done; unset valid_flag
  return 1
}

#TODO: Posix Shell compliance
process()
{
  command=""
  declare -a arguments=()
  # arguments=""

  if [ "$#" -eq 0 ]; then
    "${default_command:-:}"
    return
  fi

  for argument in "$@"; do
    if ! [ "$command" ] \
    && test=$(is_valid_command "$argument"); then
      command="${test}"
    elif is_valid_flag "$argument"; then
      "$argument"
    else
      arguments+=("$argument")
    fi; unset test
  done; unset argument

  if [ "$command" ]; then
    "$command" "${arguments[@]}"
    # "${command}" ${arguments}
    return
  else
    "${default_command:-:}"
    return
  fi
}

process "$@"
