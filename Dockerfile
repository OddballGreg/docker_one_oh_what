FROM ruby:2.7
RUN mkdir -p /src/app
COPY arbitrary_ruby_application.rb /src/app/arbitrary_ruby_application.rb
CMD ruby /src/app/arbitrary_ruby_application.rb