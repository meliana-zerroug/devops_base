#!/usr/bin/env bash 
set -e 

# Attend que l'instance soit complètement démarrée
sleep 20

# Démarre l'application avec PM2 en tant qu'app-user
sudo su - app-user -c "cd /home/app-user && pm2 start app.config.js || pm2 restart app.config.js"
sudo su - app-user -c "pm2 save"

# Vérifie que l'application répond
for i in {1..30}; do
  if curl -s http://localhost:8080 > /dev/null; then
    echo "Application is running!"
    exit 0
  fi
  sleep 2
done

echo "Application failed to start"
exit 1                