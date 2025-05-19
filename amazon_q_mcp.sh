#!/bin/bash

# Update the system and install libfuse2
sudo apt-get update -y
sudo apt-get install -y libfuse2 graphviz   # for aws-diagram-mcp-server (optional)

# Download and install Amazon Q
curl --proto '=https' --tlsv1.2 -sSf https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb -o amazon-q.deb
sudo apt install -y ./amazon-q.deb

# Install 'uv' using snap
sudo snap install astral-uv --classic

# Create config directory for Amazon Q
mkdir -p ~/.aws/amazonq

# Create mcp.json with server configuration
cat <<EOF > ~/.aws/amazonq/mcp.json
{
  "mcpServers": {
    "awslabs.cdk-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.cdk-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    },
    "awslabs.aws-diagram-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-diagram-mcp-server"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      },
      "autoApprove": [],
      "disabled": false
    }
  }
}
EOF

# Optional: Print reminder to log in manually
echo "Amazon Q installed. Please run 'q login' manually to authenticate using your Builder ID."
