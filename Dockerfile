FROM golang:1.19-bullseye

# Need these to download and install keys (below)
RUN apt-get update && \
  apt-get install apt-transport-https ca-certificates curl --yes

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
RUN mkdir -p /etc/apt/keyrings && curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

# https://helm.sh/docs/intro/install/#from-apt-debianubuntu
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

# Install Helm CLI and kubectl
RUN apt-get update && \
  apt-get install helm kubectl --yes

# https://docs.kubelinter.io/#/?id=using-go
RUN GO111MODULE=on go install golang.stackrox.io/kube-linter/cmd/kube-linter@latest

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
