modules+=("generation")
commands+=("generation")

generation()
{
  commands=("delete->generation_delete"
            "help->generation_help"
            "list->generation_list"
            "rollback->generation_rollback"
            "switch->generation_switch")
  flags=()
  default_command="generation_help"
  profproc "$@"
}
