FROM java:8-jdk

ARG install_dir=/opt/play
ENV INSTALL_DIR=${install_dir}

ARG play_version=1.3.4
ENV PLAY=play-${play_version}

RUN mkdir -p ${INSTALL_DIR}

WORKDIR ${INSTALL_DIR}

# add node repo & install curl, zip, node/npm, apt https & apt utils
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
#    && apt-get -y update \ # no need for update since above script does it
    && apt-get -y install zip nodejs \
    && apt-get -y autoclean
# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get -y update -o Dir::Etc::sourcelist="/etc/apt/sources.list.d/yarn.list" \
        -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0" \
    && apt-get -y install yarn

COPY ${PLAY}.zip ${PLAY}.zip
RUN unzip -q ${PLAY}.zip && rm ${PLAY}.zip
ENV PATH="${INSTALL_DIR}/${PLAY}:${PATH}"

CMD /bin/bash
