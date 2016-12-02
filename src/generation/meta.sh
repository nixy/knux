modules="$modules generation"
commands="$commands generation"

generation()
{
  commands="list->generation_list
            rollback->generation_rollback
            delete->generation_delete
            switch->generation_switch"
  flags=""
  default_command="generation_help"
  process "$@"
}
