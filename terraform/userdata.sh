#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create a celebratory webpage
cat <<EOT > /var/www/html/index.html
<html>
<head>
    <title>🎉 Project Deployment Success! 🚀</title>
    <style>
        body { text-align: center; font-family: Arial, sans-serif; background-color: #f0f8ff; color: #333; }
        h1 { font-size: 50px; color: #ff4500; text-shadow: 2px 2px #ffa07a; }
        h2 { font-size: 30px; color: #008000; }
        .balloons {
            font-size: 50px;
            animation: float 2s infinite alternate;
        }
        @keyframes float {
            0% { transform: translateY(0px); }
            100% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>
    <h1>🎊 Congratulations! 🎉</h1>
    <p class="balloons">🎈🎈🎈🎈🎈🎈🎈</p>
    <h2>Your Terraform Project has been successfully deployed! 🚀</h2>
    <p>Great job on completing this deployment using Infrastructure as Code! 💻</p>
    <p>Everything is up and running smoothly. Enjoy your new cloud setup! ☁️</p>
    <p style="font-size: 20px; font-weight: bold; color: #ff4500;">Deployed with Terraform ❤️</p>
    <p class="balloons">🎈🎈🎈🎈🎈🎈🎈</p>
</body>
</html>
EOT
