# Instalação

Instalar o **Operator Red Hat OpenShift GitOps**

Criar um namespace e adicionar uma instância do ArgoCD

exemplo:

```
oc new-project devops
```

Criar a *Role* abaixo para as permissões dos *Services Accounts* poderem manipular Namespaces

```
oc create -f roles/namespace-role.yaml -n devops
```

Criar os *Bindings* para cara um dos *Services Accounts*

```
oc create -f roles/namespace-role-binding-server.yaml -n devops
```

```
oc create -f roles/namespace-role-binding.yaml -n devops
```

Secret no projeto onde está o ArgoCD: 
```
argocd-default-cluster-config
```

Adicionar a chave/valor abaixo para permitir o ArgoCD realizar ajustes em namespaces

```
clusterResources: true
```
Referência
https://github.com/argoproj/argo-cd/issues/5886

## Criação da aplicação de manutenção de namespaces: 

Login no ArgoCD
```
bash
$ ARGOCD_ROUTE=$(oc -n cnd-devops get route argocd-server -o jsonpath='{.spec.host}')
$ ADMIN_PASSWORD=$(oc get secret/argocd-cluster -n cnd-devops --template='{{index .data "admin.password" | base64decode}}')
$ argocd login ${ARGOCD_ROUTE}:443 --insecure --username=admin --password=${ADMIN_PASSWORD}
```

Adição do repositório de configurações:
```
$ argocd repo add https://github.com/fernandoreb/argocd-namespaces-manager.git --name argocd-namespaces-manager --username fernandoreb --password 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
```

Criação da aplicação:
```
$ argocd app create argo-teste --dest-server https://kubernetes.default.svc --repo https://github.com/fernandoreb/argocd-namespaces-manager.git --path . --sync-policy automated
```
Forçar uma sincronização
```
argocd app sync apps
```