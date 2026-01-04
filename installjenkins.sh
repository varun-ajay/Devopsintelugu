#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt update

echo "=== Installing required packages ==="
sudo apt install -y curl gnupg ca-certificates

echo "=== Installing OpenJDK 17 ==="
sudo apt install -y openjdk-17-jdk

echo "=== Adding Jenkins GPG key ==="
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "=== Adding Jenkins repository ==="
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "=== Updating package list ==="
sudo apt update

echo "=== Installing Jenkins ==="
sudo apt install -y jenkins

echo "=== Enabling and starting Jenkins ==="
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "=== Jenkins status ==="
sudo systemctl status jenkins --no-pager

echo
echo "=== Jenkins installed successfully! ==="
echo "Access Jenkins at: http://localhost:8080"
echo
echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
