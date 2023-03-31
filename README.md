# Gitops - ArgoCD para gestão de Namespaces

Demostração de como utilizar o ArgoCD para gestionar namespaces com Openshift

## Motivação

As vezes não queremos deixar a cargo dos times de desenvolvimento a criação de namespace, Storage Claim, Roles e outros recursos do cluster.  
Podemos utilizar o ArgoCD para fazer essa adminstração. Criando uma ou mais aplicações no Argo, para fazer a gestão de namespaces.  

Imaginemos um cenário onde as áreas A e B necessitam criar namespaces para as suas aplicações e criar um pvc. Poderíamos resolver com ArgoCD da seguinte forma:

![Solução](./assets/img00.png)

## Laboratório

Openshift: 4.12

Seguem os passos para execução do laboratório.

### Instalação

Instalar o **Operator Red Hat OpenShift GitOps**

### Criação da aplicação de manutenção de namespaces: 

