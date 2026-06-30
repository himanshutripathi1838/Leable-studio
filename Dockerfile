FROM heartexlabs/label-studio:1.23.0

USER root
# Create data and app directories with correct permissions for the non-root user
RUN mkdir -p /data && chown -R 1001:0 /data && chmod -R 777 /data
RUN mkdir -p /home/user/app && chown -R 1001:0 /home/user/app && chmod -R 777 /home/user/app

# Copy the images folder from the repository build context (Git LFS) into the container
COPY --chown=1001:0 images/ /home/user/app/images/

USER 1001

# Hugging Face Spaces routes traffic to port 7860 by default
ENV PORT=7860
ENV LABEL_STUDIO_PORT=7860
ENV BASE_DATA_DIR=/data

# Fix CSRF verification failed (403) error when embedded in Hugging Face Spaces
ENV CSRF_TRUSTED_ORIGINS=https://himanshutripathi-pol.hf.space

# Enable serving local files from the app directory inside the container
ENV LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED=true
ENV LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT=/home/user/app

EXPOSE 7860

# Start Label Studio on port 7860
CMD ["label-studio", "--port", "7860"]
