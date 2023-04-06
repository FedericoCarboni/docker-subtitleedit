FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy

ARG SE_URL="https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.12/SE3612.zip"

RUN apt-get update && \
    apt-get upgrade -y

# More recent versions of tesseract and mono
RUN sudo add-apt-repository ppa:alex-p/tesseract-ocr5

RUN apt-get install gnupg ca-certificates && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt-get update

RUN apt-get install -y --no-install-recommends \
	dbus \
	fonts-wqy-microhei \
	fonts-noto-cjk \
	fonts-noto-cjk-extra \
	fonts-noto-core \
	fonts-noto-ui-core \
	fonts-noto-ui-extra \
	fonts-roboto \
	mono-complete \
	libhunspell-dev \
	libmpv-dev \
	tesseract-ocr \
	vlc \
	ffmpeg \
	jq \
	curl \
	wget \
	xz-utils \
	unzip

RUN curl -o /tmp/SE3612.zip -L ${SE_URL} && \
	mkdir -p /opt/subtitleedit && \
	unzip /tmp/SE3612.zip -d /opt/subtitleedit && \
	chmod +x /opt/subtitleedit/SubtitleEdit.exe

EXPOSE 3000

COPY root/ /
