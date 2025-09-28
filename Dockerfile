# Use Node.js base image
FROM node:16

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining app files
COPY . .

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
