FROM kasmweb/core-ubuntu-focal:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN apt-get update \
    && apt-get install -y gcc \
    && apt-get install -y git \
    && apt-get install -y curl \
    && apt-get install -y python3 \
    && apt-get install -y python3-dev \
    && apt-get install -y python3-pip \
    && apt-get install -y python3-venv \
    && apt-get install -y libxml2-dev \
    && apt-get install -y libxslt1-dev \
    && apt-get install -y libjpeg-dev \
    && apt-get install -y libopenjp2-7-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libffi-dev \
    && apt-get install -y libssl-dev \
    && apt-get install -y cargo \
    && apt-get install -y rustc

# Set up python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"



RUN mkdir -p $HOME/spiderfoot
WORKDIR $HOME/spiderfoot
# Copy spiderfoot source code files
COPY . .


ENV SPIDERFOOT_DATA /var/lib/spiderfoot
ENV SPIDERFOOT_LOGS /var/lib/spiderfoot/log
ENV SPIDERFOOT_CACHE /var/lib/spiderfoot/cache

# # Create user for spiderfoot
RUN mkdir -p $SPIDERFOOT_DATA \
 && mkdir -p $SPIDERFOOT_LOGS \
 && mkdir -p $SPIDERFOOT_CACHE \
 && chown kasm-user:kasm-user $SPIDERFOOT_DATA \
 && chown kasm-user:kasm-user $SPIDERFOOT_LOGS \
 && chown kasm-user:kasm-user $SPIDERFOOT_CACHE


# Install requirements.txt
RUN pip3 install -r requirements.txt


EXPOSE 5001



USER root
# Install Firefox
COPY ./kasm_stuff/firefox/ $INST_SCRIPTS/firefox/ 
COPY ./kasm_stuff/firefox/firefox.desktop $HOME/Desktop/
RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/

# Update the desktop environment to be optimized for a single application
RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/extra/backgrounds/bg_kasm.png /usr/share/extra/backgrounds/bg_default.png
RUN apt-get remove -y xfce4-panel

# Setup the custom startup script that will be invoked when the container starts. Spiderfoot python script will also be started with this script
ENV LAUNCH_URL  http://localhost:5001
COPY ./kasm_stuff/firefox/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

# Install Custom Certificate Authority
# COPY ./kasm_stuff/certificates/ $INST_SCRIPTS/certificates/
# RUN bash $INST_SCRIPTS/certificates/install_ca_cert.sh && rm -rf $INST_SCRIPTS/certificates/

ENV KASM_RESTRICTED_FILE_CHOOSER=1
COPY ./kasm_stuff/gtk/ $INST_SCRIPTS/gtk/
RUN bash $INST_SCRIPTS/gtk/install_restricted_file_chooser.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME/spiderfoot
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000