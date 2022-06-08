#!/usr/bin/env bash

# Rosie, the housekeeper. https://en.wikipedia.org/wiki/List_of_The_Jetsons_characters#Rosie

# Tasks
# - [ ] rosie help
# - [ ] rosie setup
# - [ ] rosie doctor
# - [ ] rosie cron

(
	# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
	readonly ROSIE_HOME="${ROSIE_HOME:-$HOME/repos/cli}"
	readonly ROSIE_REPO="${ROSIE_REPO:-'https://github.com/joeljuca/cli.git'}"

	readonly ROSIE_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config/rosie}"
	readonly ROSIE_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache/rosie}"
	readonly ROSIE_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share/rosie}"
	readonly ROSIE_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state/rosie}"

	# mkdir -p "${ROSIE_CONFIG_HOME}"
	# mkdir -p "${ROSIE_CACHE_HOME}"

	# FYI, `declare -a` explicity declares a variable as an array
	declare -ar available_subcommands=(
		"cron"
		"doctor"
		"help"
		"setup"
	)

	function main {
		local subcommand="${1}"

		log "Running Rosie"

		# show help if no subcommand is given
		if [ "${1}" == "" ]; then
			err "Missing subcommand"
			exit 1
		fi

		# execute subcommand if it exists
		if [[ "${available_subcommands[*]}" =~ "${1}" ]]; then
			log "Executing subcommand ${subcommand}"
			"subcommand_${subcommand}"
			exit 0
		fi

		# if no subcommand is found, show error and exists
		err "Unknown subcommand ${subcommand}"
		exit 1
	}

	# Subcommands

	# $ rosie cron

	function subcommand_cron {
		echo "To be implemented"
		exit 1
	}

	function subcommand_doctor {
		# - Checklist
		#   - [x] Underworld dir (~/.underworld) exists?
		#     - [ ] Git repo is correctly set?
		#     - [ ] Contents are protected?
		#   - [ ] Executables permissions look right?
		#   - [ ] Private keys are symlinked?

		echo "To be implemented"
		exit 1

		# WIP

		# if [[ ! -d "${ROSIE_HOME}" ]]; then
		#   err "Underworld directory absent. \$ROSIE_HOME: ${ROSIE_HOME}"

		#   exit 1
		# fi
	}

	# $ rosie setup

	function subcommand_setup {
		# - [x] ensure Underworld is available in ~/.underworld and
		#   - [x] Git repo is correctly set
		#   - [x] contents are protected
		# - [ ] setup permissions for executables
		# - [ ] setup private keys
		#   - [ ] ensure keys are protected
		#   - [ ] ensure keys are symlinked

		setup_ROSIE_repo
	}

	# Setup steps

	function setup_repo {
		mkdir -p "${ROSIE_HOME}"
		chmod -R 700 "${ROSIE_HOME}"

		if [[ ! -d "${ROSIE_HOME}/.git" ]]; then
			git clone "${ROSIE_REPO}" "${ROSIE_HOME}"
		fi

		doctor_repo
	}

	function doctor_repo {
		if [[ ! -d "${ROSIE_HOME}" ]]; then
			err "Rosie repository does not exist"
			exit 1
		fi

		for file in "$(ls -1A '${ROSIE_HOME}')"; do
			echo "file: ${file}"

			# if [  -x $file   ]; then
			#   err "Underworld local repository doesn't look right"

			#   exit 1
			# fi
		done

		if ! git -C "${ROSIE_HOME}" remote -v | grep "${ROSIE_REPO}" >>/dev/null 2>&1; then
			err "joeljuca/cli repository doesn't look right"

			exit 1
		fi
	}

	# $ rosie help

	function subcommand_help {
		echo <<HELP
# Rosie, the housekeeper.

Rosie is my command-line utility to perform a variety of personal tasks.

Synopsis:

    $ rosie [subcommand] [arguments ...]

Usage:

    $ rosie help      Show this help
    $ rosie setup     Run the automated setup
    $ rosie doctor    Run multiple checks, reporting back if anything looks wrong
    $ rosie cron      Run tasks scheduled to run periodically.

--
2022 Joel Jucá. https://github.com/joeljuca/cli

The name Rosie comes from the TV show The Jetsons, where a robot maid named Rosie handles general housekeeping chores for the futuristic family.
HELP

		exit 0
	}

	# Utils

	function log {
		echo "$(timestamp) LOG: ${@}" | tee -a "${ROSIE_CACHE_HOME}/rosie.log"
	}

	function err {
		echo "$(timestamp) ERR: ${@}" | tee -a "${ROSIE_CACHE_HOME}/rosie.log"
	}

	function timestamp {
		TZ=UTC date "+%Y-%m-%dT%H:%M:%SZ"
	}

	# Bootstrap script

	main $@
)
