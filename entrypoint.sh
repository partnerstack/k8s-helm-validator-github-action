#!/bin/sh -l

usage() {
  echo "Usage: $0 -c CHART_DIRECTORY [ -v VALUES_DIRECTORY ]" 1>&2 
}

exit_with_error() {                         # Function: Exit with error.
  usage
  exit 1
}

while getopts ":c:v:" options; do         # Loop: Get the next option;
                                          # use silent error checking;
                                          # options n and t take arguments.
  case "${options}" in                    # 
    c)                                    # If the option is n,
      CHART_DIRECTORY=${OPTARG}                      # set $NAME to specified value.
      ;;
    v)                                    # If the option is t,
      VALUES_DIRECTORY=${OPTARG}          # Set $TIMES to specified value.
      ;;
    :)                                    # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_with_error                       # Exit abnormally.
      ;;
    *)                                    # If unknown (any other) option:
      exit_with_error                       # Exit abnormally.
      ;;
  esac
done

for VALUES_FILE in $VALUES_DIRECTORY/*; do
    helm template $CHART_DIRECTORY --values="$VALUES_FILE" | kube-linter lint .
    helm template $CHART_DIRECTORY --values="$VALUES_FILE" | kubectl apply --dry-run=client -f -
done
