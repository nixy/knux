# Searches packages using basic regular expressions.
# Arguments: A list of basic regular expressions to search package names with.
# Effects:   None
# Returns:   A list of package names that matched the regular expression.
list()
{
  if [ -t 0 ]; then
    echo "listing..." >&2
  fi
  PAGER="" nix-env -qa "${@}";
}
