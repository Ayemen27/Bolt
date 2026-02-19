#!/bin/bash

# Configuration from environment (pre-set or from .env)
# The script will use the values provided during the session
SSH_HOST="93.127.142.144"
SSH_USER="administrator"
SSH_PASS="Ay**772283228"
REMOTE_APP_PATH="/home/administrator/bolt"

echo "Connecting to $SSH_HOST and deploying to $REMOTE_APP_PATH..."

# SSH commands to execute on the remote server
sshpass -p "$SSH_PASS" ssh -o StrictHostKeyChecking=no "$SSH_USER@$SSH_HOST" << 'EOF'
    # Navigate to app directory
    cd "/home/administrator/bolt" || { echo "Directory not found"; exit 1; }
    
    echo "1. Resetting local changes and pulling from main..."
    # Force reset to ensure git pull doesn't fail due to divergent branches
    git fetch origin
    git reset --hard origin/main
    
    echo "2. Cleaning and installing dependencies..."
    # npm error 'matches' usually suggests a corrupted node_modules or cache
    rm -rf node_modules package-lock.json
    npm install --omit=dev || npm install
    
    echo "3. Building the application..."
    npm run build
    
    echo "4. Restarting the application..."
    # Check if PM2 is running the app, else start it
    if command -v pm2 &> /dev/null; then
        pm2 restart all || pm2 start npm --name "bolt-app" -- start
        pm2 save
    else
        echo "PM2 not found. Using nohup fallback..."
        pkill -f "node" || true
        nohup npm start > app.log 2>&1 &
    fi
    
    echo "Deployment successfully finished on remote server."
EOF
