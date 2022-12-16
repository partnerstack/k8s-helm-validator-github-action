# Validate Helm charts and their values files using a GitHub Action

Problem that we often ran into was that most Kubernetes YAML validators will only check if your Helm chart templates themselves are valid. Which means if your values files used for different environments will cause the substitions to generate invalid manifests, you might not catch it until deployment time. At which point the bad template(s) and/or values file(s) are already committed to the master/main branch, and is now unstable.

This action aims to help by allowing you to supply multiple value files so they can all be rendered and validated. This should mean that hopefully you should be able to reduce the likelihood that a Helm chart will be invalid for a given deployment target.

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

uses: actions/hello-world-docker-action@v2
with:
  who-to-greet: 'Mona the Octocat'

## Testing

### Locally run the script

```bash
./entrypoint.sh -c example-chart -v example-chart/values
```

### Build and run the container

```bash
docker build . --tag validate-helm-1
docker run --mount type=bind,source="$(pwd)"/example-chart,target=/etc/example-chart \
  validate-helm-1 -c example-chart -v example-chart/values
```