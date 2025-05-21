# app/Dockerfile

FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your index.html into the container
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
