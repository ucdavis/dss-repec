FROM ruby:3.1-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base nodejs npm tzdata mysql-dev

RUN apk update \
  && apk add curl bash binutils tar gnupg \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del tar binutils

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
WORKDIR /usr/src/app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 5 --without test

# Copy dependencies for Node.js and instance the packages.
# Again, being separate means this will cache.
COPY package.json yarn.lock ./
RUN yarn install
RUN npm rebuild node-sass --force

ARG RAILS_ENV=production
ENV RAILS_ENV $RAILS_ENV

ARG RACK_ENV=production
ENV RACK_ENV $RACK_ENV

ENV RAILS_ROOT /usr/src/app

# Use Rails for static files in public
ARG RAILS_SERVE_STATIC_FILES
ENV RAILS_SERVE_STATIC_FILES $RAILS_SERVE_STATIC_FILES

# Set Rack::Timeout values
ENV RACK_TIMEOUT_SERVICE_TIMEOUT 120

# Log to STDOUT
ENV RAILS_LOG_TO_STDOUT 1

ARG SECRET_KEY_BASE=changeme
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

ARG DB_HOST
ENV DB_HOST $DB_HOST
ARG DB_NAME
ENV DB_NAME $DB_NAME
ARG DB_USER
ENV DB_USER $DB_USER
ARG DB_PASSWORD
ENV DB_PASSWORD $DB_PASSWORD

ARG CAS_URL
ENV CAS_URL $CAS_URL

ARG AWS_ACCESS_KEY
ENV AWS_ACCESS_KEY $AWS_ACCESS_KEY
ARG AWS_SECRET_KEY
ENV AWS_SECRET_KEY $AWS_SECRET_KEY
ARG AWS_S3_BUCKET
ENV AWS_S3_BUCKET $AWS_S3_BUCKET
ARG AWS_S3_REGION
ENV AWS_S3_REGION $AWS_S3_REGION

# Copy the main application.
COPY . ./
RUN curl https://truststore.pki.rds.amazonaws.com/us-west-2/us-west-2-bundle.pem -o us-west-2-bundle.pem -s

# Precompile Rails assets (plus Webpack)
RUN bundle exec rake assets:precompile

# Will run on port 3000 by default
EXPOSE 3000

# create directory needed for puma pid file
RUN mkdir -p tmp/pids

# Start puma
CMD bundle exec puma -C config/puma.rb
