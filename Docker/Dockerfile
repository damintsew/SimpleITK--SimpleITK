FROM ubuntu:20.04 AS bulder

USER root

ARG BASE_DIRECTORY=/home/root
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

COPY ./apt.txt /tmp/
RUN apt-get update && \
    cat /tmp/apt.txt | xargs apt-get install -y --no-install-recommends && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p ${BASE_DIRECTORY}/work/build

ENV BRANCH=${BRANCH}

WORKDIR $BASE_DIRECTORY/work
RUN git clone https://github.com/SimpleITK/SimpleITK \
    && cd SimpleITK && git checkout $BRANCH

WORKDIR $BASE_DIRECTORY/work/build

RUN cmake ../SimpleITK/SuperBuild; \
    make -j 6

FROM python:3.8

ARG BASE_DIRECTORY=/home/root
RUN mkdir -p ${BASE_DIRECTORY}/work/build/SimpleITK-build/Wrapping/Python

COPY --from=bulder $BASE_DIRECTORY/work/build/SimpleITK-build/Wrapping/Python \
    $BASE_DIRECTORY/work/build/SimpleITK-build/Wrapping/Python

COPY --from=bulder $BASE_DIRECTORY/work/build/SimpleITK-build/ITK-5.1-NOTICE \
        $BASE_DIRECTORY/work/build/SimpleITK-build/ITK-5.1-README.md \
        $BASE_DIRECTORY/work/build/SimpleITK-build/

COPY --from=bulder $BASE_DIRECTORY/work/SimpleElastix/LICENSE \
        $BASE_DIRECTORY/work/SimpleElastix/NOTICE \
        $BASE_DIRECTORY/work/SimpleElastix/README.md $BASE_DIRECTORY/work/SimpleElastix/

WORKDIR $BASE_DIRECTORY/work/build/SimpleITK-build/Wrapping/Python
RUN python Packaging/setup.py install
