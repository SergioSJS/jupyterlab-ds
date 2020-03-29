FROM sergiosjs/jupyterlab-plotly

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl \
        wget \
        gfortran \
        cmake \
        bsdtar  \
        rsync \
        imagemagick \
        gnuplot-x11 \
        libxtst6 \
        libgtk2.0.0 \
        libgconf2-4 \
        xvfb \
        libxss1 \
        libopenblas-base \
        python3-dev && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chmod -R 777 $HOME/work/
RUN pip install --upgrade pip

# Copy and install requirements
COPY requirements.txt $HOME/work
RUN cd $HOME/work;\
    pip install -r requirements.txt

# Download orca AppImage, extract it, and make it executable under xvfb
RUN wget https://github.com/plotly/orca/releases/download/v1.1.1/orca-1.1.1-x86_64.AppImage -P /home
RUN chmod 777 /home/orca-1.1.1-x86_64.AppImage 

# To avoid the need for FUSE, extract the AppImage into a directory (name squashfs-root by default)
RUN cd /home && /home/orca-1.1.1-x86_64.AppImage --appimage-extract
RUN printf '#!/bin/bash \nxvfb-run --auto-servernum --server-args "-screen 0 640x480x24" /home/squashfs-root/app/orca "$@"' > /usr/bin/orca
RUN chmod 777 /usr/bin/orca
RUN chmod -R 777 /home/squashfs-root/

WORKDIR $HOME/work

USER $NB_UID
