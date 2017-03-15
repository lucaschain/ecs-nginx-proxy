FROM nginx:latest

WORKDIR /root/

RUN apt-get update && apt-get install -y -q --no-install-recommends curl unzip && apt-get clean

# download release of ecs-gen
ENV ECS_GEN_RELEASE 0.3.1
#RUN curl -OL https://github.com/codesuki/ecs-gen/releases/download/$ECS_GEN_RELEASE/ecs-gen-linux-amd64.zip && unzip ecs-gen-linux-amd64.zip && cp ecs-gen-linux-amd64 /usr/local/bin/ecs-gen

COPY ecs-gen-linux-amd64 /usr/local/bin/ecs-gen

COPY nginx.tmpl nginx.tmpl
COPY .htpasswd /etc/nginx/.htpasswd

CMD nginx && ecs-gen --signal="nginx -s reload" --region=us-east-2 --template=nginx.tmpl --output=/etc/nginx/conf.d/default.conf
