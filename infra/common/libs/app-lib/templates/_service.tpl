{{- define "app-lib.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "app-lib.fullname" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "app-lib.selectorLabels" . | nindent 4 }}
{{- end }}
