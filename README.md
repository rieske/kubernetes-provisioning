## Prerequisites

- `vagrant`
- `libvirt`
- `ansible`

## Spawning the VMs

```
vagrant up
```

## Destroying the VMs

```
vagrant destroy -f
```

## Provisioning the Kubernetes cluster

```
./vagrant-provision.sh
```

## Troubleshooting

### Flannel

Show pod status: `kubectl get pod --namespace kube-flannel -l app=flannel`
Show pod logs: `kubectl logs --namespace kube-flannel <POD_ID> -c kube-flannel`

