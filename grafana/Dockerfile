FROM alpine:latest as dev
COPY preset.sh /grafana/preset.sh
COPY telegraf-metrics_rev3.json /grafana/telegraf-metrics_rev3.json
RUN apk update && apk upgrade && apk add curl jq
ENTRYPOINT [ "sh", "/grafana/preset.sh" ]
