# Removes packages with no active references in any generation or profile.
# Arguments: A list of package names to upgrade. If no package names are given,
#            then upgrade all packages in the current profile.
# Effects:   Purges packages with no active references to them. Depending on the
#            flags provided this may also remove old generations before purging
#            packages.
# Returns:   Progress information on the purge  and confirmation of package
#            deletion.
garbage_collect()
{
  nix-collect-garbage "$@"
}
