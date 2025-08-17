#!/bin/bash
set -e

echo "🚀 Updating system..."
sudo apt update && sudo apt full-upgrade -y

echo "📦 Installing prerequisites..."
sudo apt install -y curl gnupg2 lsb-release software-properties-common build-essential

echo "🔑 Adding ROS 2 GPG key..."
sudo mkdir -p /usr/share/keyrings
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "📂 Adding ROS 2 repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo "🔄 Updating package index..."
sudo apt update

echo "🐢 Installing ROS 2 Humble (base + demos)..."
sudo apt install -y ros-humble-ros-base ros-humble-demo-nodes-cpp ros-humble-demo-nodes-py

echo "⚙️ Setting up environment..."
if ! grep -q "source /opt/ros/humble/setup.bash" ~/.bashrc; then
  echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
fi
source ~/.bashrc

echo "✅ ROS 2 Humble installation complete!"
echo "👉 Open a new terminal and try:"
echo "   ros2 run demo_nodes_cpp talker"
echo "   ros2 run demo_nodes_cpp listener"
