# Match host glibc (RHEL 8 / glibc 2.28) so mounted OPAM binaries stay compatible.
FROM rockylinux:8

ARG OPAM_VERSION=2.2.1
ARG PANDOC_VERSION=3.6.4
ARG OPAMROOT=/lm/users/arul/.opam

RUN dnf install -y epel-release \
 && crb enable \
 && dnf install -y \
      git \
      gcc \
      gcc-c++ \
      make \
      patch \
      unzip \
      wget \
      which \
      findutils \
      diffutils \
      gmp-devel \
      python3 \
      texlive \
      texlive-latex \
      texlive-collection-latexrecommended \
 && dnf clean all \
 && rm -rf /var/cache/dnf

RUN wget -q -O /tmp/pandoc.tar.gz \
      "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz" \
 && tar -xzf /tmp/pandoc.tar.gz --strip-components=1 -C /usr/local \
 && rm /tmp/pandoc.tar.gz

RUN wget -q -O /usr/local/bin/opam \
      "https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-x86_64-linux" \
 && chmod +x /usr/local/bin/opam

WORKDIR /workspace

COPY docker/entrypoint.sh docker/serve.sh /docker/
RUN chmod 755 /docker/entrypoint.sh /docker/serve.sh

ENV OPAMROOT=${OPAMROOT} \
    OPAMSWITCH=default \
    PATH="/usr/local/bin:${PATH}"

ENTRYPOINT ["/bin/bash", "/docker/entrypoint.sh"]
CMD ["bash"]
