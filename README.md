# nixy

An easy to use CLI front-end to the Nix package management system. The goal of
this project is to make Nix easier to use to help people get into Nix.

This is intended to be a high level shiny CLI that doesn't have to get bogged
down in the details of being able to do everything, as the low level Nix tools
already exist.

## How does it work?

Most of what Nixy does is wrap the low level Nix tools in some error handling
and more intuitive interfaces. For example to install a package using Nix
normally you use the command:

	nix-env -e <package>

Which is fairly straightforward, but with nixy you can do:

	nixy remove <package>

This gives nixy more in common with popular package managers, such as apt and
brew which will hopefully help to increase Nix adoption.

In addition nixy has a module system that while incomplete will hopefully allow
people to easily add their own submodule to simplify their Nix workflow.
Currently there is a completed module for managing generations of your profile
and there is a rough module for managing profiles.

The goal here is to let other people write simple modules that encapsulate their
workflow for something like writing golang packages. 

## Installing it

Currently the project is just a bash script that is composed using make. Running
make should output the complete script as bin/nixy, which you can then put
somewhere in your path to use.

I am currently working on a more complete makefile to support installation and
getting a Nix expression finished up.
