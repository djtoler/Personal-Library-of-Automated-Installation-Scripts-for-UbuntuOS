# Use an nginx image


# Install Git in the alpine nginx image
RUN apk add --no-cache git

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Clone GitHub repository into a temporary directory


# Expose port 80 for the nginx server


# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
