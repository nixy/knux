modules="${modules}
         development"
commands="${commands}
          build
          shell"
flags="${flags}"

build()
{
  nix-build "${@}"
}

shell()
{
  nix-shell  "${@}"
}
