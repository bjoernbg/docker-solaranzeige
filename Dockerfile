FROM php:7.4-buster

# Install cron
RUN apt-get update && apt-get install -y cron

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron

# Add shell script and grant execution rights
ADD trigger.sh /trigger.sh
RUN chmod +x /trigger.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

VOLUME ["/solaranzeige-php", "/solaranzeige-log", "/solaranzeige-user-code"]

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log