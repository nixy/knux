profile_list()
{
  # if [ "${#}" -gt 0 ]; then
  #   echo -e "\e[1;31merror:\e[0m no arguments expected"
  #   exit 1
  # fi
  
  for profile in /nix/var/nix/profiles/*; do
    profile=$(basename "${profile}")
    if [ "${profile}" != "per-user" ] && [ "${profile}" != "system" ]; then
      # Ignore profile generations
      if grep -qv '\-[0-9]*-link' <<< $profile; then
	echo " "system/${profile}
      fi
    fi
  done; unset profile

  for profile in /nix/var/nix/profiles/per-user/"${USER}"/*; do
    profile=$(basename "${profile}")
    if grep -qv '\-[0-9]*-link' <<< $profile; then
      echo " "${USER}/${profile}
    fi
  done; unset profile
}
