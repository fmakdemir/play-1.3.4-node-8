FROM java:8-jdk

ARG install_dir=/opt/play
ENV INSTALL_DIR=${install_dir}

ARG play_version=1.3.4
ENV PLAY=play-${play_version}

RUN mkdir -p ${INSTALL_DIR}

WORKDIR ${INSTALL_DIR}
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get update \
    && apt-get install -y curl zip nodejs \
    && apt-get -y autoclean

COPY ${PLAY}.zip ${PLAY}.zip
RUN unzip -q ${PLAY}.zip && rm ${PLAY}.zip
ENV PATH="${INSTALL_DIR}/${PLAY}:${PATH}"

CMD /bin/bash
