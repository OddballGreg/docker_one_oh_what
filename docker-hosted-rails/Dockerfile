FROM ruby:2.7.1-alpine AS develop
RUN mkdir -p /src/app
WORKDIR /src/app
COPY Gemfile* ./
ENV GEM_HOME /box
ENV BUNDLE_PATH /box
ENV BUNDLE_BIN /box/bin
ENV BUNDLE_APP_CONFIG /box
ENV PATH="/box/bin:${PATH}"
