{{- define "llm-serving.secretName" -}}
  {{- printf "%s-s3" .Release.Name | lower -}}
{{- end }}