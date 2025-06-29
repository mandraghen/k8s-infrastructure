{{- define "app-lib.route" -}}
{{- if .Values.route.enabled -}}
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ include "app-lib.fullname" . }}-route
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
  {{- with .Values.route.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  parentRefs:
    {{- with .Values.route.gateway }}
    - name: {{ .name }}
      namespace: {{ .namespace }}
    {{- end }}
  {{- if .Values.route.hostnames }}
  hostnames:
    {{- range .Values.route.hostnames }}
    - {{ . | quote }}
    {{- end }}
  {{- end }}
  rules:
    - backendRefs:
        - name: {{ include "app-lib.fullname" $ }}
          port: {{ $.Values.service.port }}
{{- end }}
{{- end }}
