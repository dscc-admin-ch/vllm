{{- define "llm-serving.secretName" -}}
  {{- printf "%s-s3" .Values.fullnameOverride | lower -}}
{{- end }}