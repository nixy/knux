modules="$modules profile"
commands="$commands profile"

profile()
{
  commands="list->profile_list
            create->profile_create
            delete->profile_delete
            switch->profile_switch"
  flags=""
  default_command="profile_help"
  process "$@"
}
