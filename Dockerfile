FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html

WORKDIR /app/

RUN mkdir -p /app/files/

COPY ./ /app/

COPY sshd_config /etc/ssh/

# Start and enable SSH
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd \
     && chmod +x /app/init_container.sh \
     && cd /etc/ssh/ \
     && ssh-keygen -A

EXPOSE 80 2222

ENTRYPOINT [ "/app/init_container.sh" ] 