FROM ubuntu:20.04
MAINTAINER Keith Suderman <suderman@jhu.edu>

# This Dockerfile is based on the Gist by Bryan Nguyen with some modifications.
# The original can be found at:
# https://gist.github.com/dongchirua/657447d1d3174b653373f9aa55977483
# MAINTAINER Bryan Nguyen <dongchirua@live.com>
# www.nhquy.com

ARG DEBIAN_FRONTEND=noninteractive

# install some dependencies 
RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends\
    apt-transport-https \
    #ssh-client \
    build-essential \
    #curl \
    ca-certificates \
    git \
    libicu-dev \
    'libicu[0-9][0-9].*' \
    #lsb-rlease \
    python-all \
    #rlwrap \
    #apt-utils \
    #libssl-dev \
    graphicsmagick --fix-missing \
    imagemagick --fix-missing \
    nodejs \
    npm \ 
    sudo \
    xvfb \
    libfontconfig \
    wkhtmltopdf \
    ffmpeg \
    sox \
    libsox-fmt-mp3 \
    ghostscript \
    zlibc zlib1g-dev zlib1g \
    #emacs \
    jq \
    iproute2
    
#RUN npm install -g pangyp\
# 		&& ln -s $(which pangyp) $(dirname $(which pangyp))/node-gyp\
# 		&& npm cache clear\
# 		&& node-gyp configure || echo ""

# install forever, bower and grunt
#RUN npm install forever -g && \
#    npm install -g bower && \
#    npm install -g grunt-cli
    
# install ruby
RUN apt install -y ruby ruby-dev ruby-bundler \
    && gem install bundler \
    && rm /etc/ImageMagick-6/policy.xml
    
COPY make-video.sh /usr/local/bin/
RUN useradd -ms /bin/bash galaxy && \
    echo 'galaxy ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chmod +x /usr/local/bin/make-video.sh
    
USER galaxy
RUN mkdir /home/galaxy/training-material
COPY Gemfile /home/galaxy/training-material/

WORKDIR /home/galaxy/training-material

RUN bundle config path vendor/bundle \
    && bundle install --jobs 4 --retry 3

ENTRYPOINT ["make-video.sh"]
#CMD ["/bin/bash"]