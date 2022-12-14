FROM        node:16.17.1-buster-slim

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 python3 ca-certificates tzdata dnsutils build-essential wget gnupg libcairo2-dev libjpeg-dev libcogl-pango-dev libgif-dev \
            && npm install -g npm@8.19.2 \
            && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
            && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
            && apt-get update \
            && apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
                --no-install-recommends \
            && rm -rf /var/lib/apt/lists/* \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

RUN         groupadd -r container && useradd -d /home/container -r -g container -G audio,video container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]