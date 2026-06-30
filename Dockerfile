FROM heartexlabs/label-studio:1.23.0

USER root
# Create data directory and set permissions so the non-root user can write to it
RUN mkdir -p /data && chown -R 1001:0 /data && chmod -R 777 /data
USER 1001

# Hugging Face Spaces routes traffic to port 7860 by default
ENV PORT=7860
ENV LABEL_STUDIO_PORT=7860
ENV BASE_DATA_DIR=/data

# Fix CSRF verification failed (403) error when embedded in Hugging Face Spaces
ENV CSRF_TRUSTED_ORIGINS=https://himanshutripathi-pol.hf.space

EXPOSE 7860

# Start Label Studio on port 7860
CMD ["label-studio", "--port", "7860"]
