# Gitops - ArgoCD para gestão de Namespaces

Openshift: 4.12

## Motivação

As vezes não queremos deixar a cargo dos times de desenvolvimento a criação de namespace, Storage Claim e outros recursos do cluster como Roles. 
Podemos utilizar o ArgoCD para fazer essa adminstração, criando uma ou mais aplicações no Argo, para fazer a gestão de namespaces.

# Instalação

Instalar o **Operator Red Hat OpenShift GitOps**

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