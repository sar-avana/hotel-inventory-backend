# Use official Ruby image as a base
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

# Set working directory
WORKDIR /app

# Copy Gemfiles
COPY Gemfile* ./

# Add this line to copy the master key into the image
COPY config/master.key /app/config/master.key

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets if needed (optional)
# RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
