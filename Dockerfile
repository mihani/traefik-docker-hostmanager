FROM traefik:v3.4.1

LABEL traefik.enable="true" \
     traefik.http.routers.traefik="true" \
     traefik.http.routers.traefik.tls="true"

COPY traefik/dynamic-conf.yaml /etc/traefik/dynamic_conf.yaml
COPY traefik/static-conf.yaml /etc/traefik/traefik.yaml
COPY certs /etc/certs

EXPOSE 443
EXPOSE 8080
EXPOSE 80
