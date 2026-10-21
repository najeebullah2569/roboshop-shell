dnf install -y nginx
STATUS=$?

if [ "$STATUS" -eq 0 ]; then
    echo "Node.js installation successful"
else
    echo "Node.js installation failed: exit code $STATUS"
    exit "$STATUS"
fi

echo -e \\e[6m Copy nginx configuration \\e[0m
cp nginx.conf /etc/nginx/nginx.conf
echo $?

echo -e \\e[36m Installing nodejs \\e[0m
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs
echo $?

echo -e \\e[36m Downloading fronted code \\e[0m
curl -L -o /tmp/frontend.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip
echo $?

echo -e \\e[36m Removing tpm directory \\e[0m
rm -rf /tmp/frontend
mkdir -p /tmp/frontend && cd /tmp/frontend
echo $?

echo -e \\e[36m Extracting Fronded Code \\e[0m
unzip /tmp/frontend.zip
echo $?

echo -e \\e[36m Compiling Frontend Code \\e[0m
npm install
npm run build
echo $?

echo -e \\e[36m Copy Compile Code to nginx \\e[0m
rm -rf /usr/share/nginx/html/*
cp -r out/* /usr/share/nginx/html/
echo $?

echo -e \\e[36m Restart Nginx \\e[0m
systemctl enable nginx
systemctl restart nginx


