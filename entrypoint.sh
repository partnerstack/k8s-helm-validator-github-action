#!/bin/sh -l

CHART_DIRECTORY=example-chart
VALUES_DIRECTORY=example-chart/values

for VALUES_FILE in $VALUES_DIRECTORY/*; do
    helm template $CHART_DIRECTORY --values="$VALUES_FILE"
done
