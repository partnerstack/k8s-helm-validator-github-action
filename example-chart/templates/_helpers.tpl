# Generate a safe-to-use short commit SHA or tag
{{- define "suffixTemplate" -}}
{{- .Values.tag | toString | replace "." "-" -}}
{{- end -}}
