Install via ansible: helm, kubernetes, deploy grafana/loki/promtail 

### Create ansible variable

- create the file ./var/main.yml by taking as example the file ./vars/main.yml.example
- create the file ./var/k8s.yml by taking as example the file ./vars/k8s.yml.example
- update it with your data

### Install
```bash
# by being at the root of the project
./scripts/install-k8s.sh
```

### grafana

login: `admin`
the password is the value of `grafana_password` set in `./vars/k8s.secrets.yml`

Or you can cover the password by running this command:
```
kubectl get secret -n monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

To access to the grafana UI: http://localhost:30300/