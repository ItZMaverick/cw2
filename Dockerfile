# Base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy the application code
COPY server.js .

# Install required packages


# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["node", "server.js"]
