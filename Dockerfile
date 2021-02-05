FROM 9mine/9p-execfuse-jinja2:master
RUN curl -s https://api.github.com/repos/vultr/vultr-cli/releases/latest | \
    jq -r '.assets[] | select(.browser_download_url | test(".linux_64-bit.tar.gz")) | .browser_download_url' | \
    xargs curl -L -o latest.tar.gz && tar xvf latest.tar.gz && install vultr-cli /usr/local/bin