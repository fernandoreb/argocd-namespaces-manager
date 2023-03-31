{{/*
Expand the name of the chart.
*/}}

{{- define "argocd-applications-manager.defaultLabels" -}}
argocd.argoproj.io/managed-by: openshift-gitops
{{- end }}
