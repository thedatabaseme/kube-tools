# TheDatabaseMe kube-tools

kube-tools is a Docker container image, that helps you in working with Kubernetes clusters.

The following tools and packages are included:

- git
- direnv
- gomplate
- kubectl
- kustomize
- k9s
- kubectx / kubens
- kind
- Helm
- Docker
- Ansible core
- Ansible collections: `ansible.posix`, `community.docker`, `community.general`, `kubernetes.core`


## Deploy and use kube-tools

kube-tools comes especially handy, when working with Docker on Windows. You don't have to
worry about tools, that might not be available for your Windows machine. 
### Windows

To run `kube-tools` on your Windows machine, run the following command in your Powershell.
You probably want to adjust the volume mounts to your needs / folder structure. The volume
mount of `/var/run/docker.sock` is only needed, when you want to run Docker from inside
Docker.

```bash
docker run -it -v ${PWD}/project:/project -v $home/.kube:/root/.kube -v /var/run/docker.sock:/var/run/docker.sock --network=host --rm --workdir /project ghcr.io/thedatabaseme/kube-tools:latest
```

You may want to exclude the `--network=host` parameter in your `docker run` command. I added it to this
example for the reason if you want to work with `kind` to create a Kubernetes cluster running on your
Docker Host also as container. You will not be able to connect to the `kind` created cluster because it refers
to `localhost` by default.

### Linux

To run `kube-tools` onto your Linux / WSL, run the following command. You probably want to
adjust the volume mounts to your needs / folder structure. The volume mount of 
`/var/run/docker.sock` is only needed, when you want to run Docker from inside Docker.

```bash
docker run -it -v ~/project:/project -v ~/.kube:/root/.kube -v /var/run/docker.sock:/var/run/docker.sock --network=host --rm --workdir /project ghcr.io/thedatabaseme/kube-tools:latest
```
