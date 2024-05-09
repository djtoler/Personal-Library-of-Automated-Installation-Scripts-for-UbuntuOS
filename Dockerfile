# Use an nginx image
FROM nginx:alpine

# Install Git in the alpine nginx image
RUN apk add --no-cache git

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Clone your GitHub repository into a temporary directory
RUN git clone https://github.com/djtoler/hwthdemo.git /tmp/hwthdemo && \
    mv /tmp/hwthdemo/hwth.html ./index.html && \
    rm -rf /tmp/hwthdemo/.git

# Copy the color check script into the container
COPY test.sh /usr/local/bin/test.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/test.sh

# Expose port 80 for the nginx server
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
