# 🌐 Hyperspace Node Installation Guide

## ⚙️ System Requirements

| Component | Minimum Specs |
|-----------|---------------|
| CPU       | 2 cores       |
| RAM       | 4GB           |
| Storage   | 10 GB SSD     |
| OS        | Ubuntu 24.04  |
| Port      | 50051         |

### 1. System Update 🖥️
Before starting the installation, ensure your system is up to date:
```bash
sudo apt update && sudo apt upgrade -y
```
### 2. Install aiOS CLI ⚙️
Install the aiOS CLI using the following command:
```bash
curl https://download.hyper.space/api/install | bash
```
### 3. Get your private key 🔑

Before starting the installation **you need to obtain your private key** . Perform the following steps:

1.  Visit [https://node.hyper.space/](https://node.hyper.space/) .
    
2.  **Enable Browser node** : On the home screen of the website, you will see a switch (located under the key icon in the upper left corner). Click it to enable the browser node.
    
3.  After the browser node is powered on, click the key icon.
    
4. Now click **"COPY CURRENT PRIVATE KEY”** . This will copy the private key to the clipboard.
    
5.  Save this key in a safe place, as you will need to paste it into the `.pem` file during the installation process.

### 4. install Hyperspace Node ⚙️
```bash
curl -sL -o hyperspace https://raw.githubusercontent.com/TmB0o0/Hyperspace-Node/refs/heads/main/hyperspace
chmod +x hyperspace
./hyperspace
```
-   **Installation Process**: The script will add the necessary models, ask you to create a `.pem` file for the private key, and complete the setup by selecting tiers.
    
-   **Warning**: The script might throw you out of the terminal on the first attempt. If this happens, reconnect to your server and rerun the script.

### Usage Options ⚙️

Once the installation is complete, you can perform the following actions via the script's menu:

-   **Check Points**: This will show the status of your points with the `aios-cli hive points` command.
    
-   **Update Node**: This will show the current version of your node using the `aios-cli version` command.
    
-   **Show Logs**: This connects to the screen session named `hyperspace` and shows the logs from the running process. If the session isn't found, it will notify you.
    
    **Note**: If you need to detach from the screen session, press `Ctrl + A`, then `D`.
    
-   **Uninstall Node**: This will prompt for confirmation to uninstall the node. If confirmed, the node will be removed using the uninstall command.
    
-   **Exit**: This will exit the script. 
#### Return  🚪 Press Ctrl+A then D to detach.

Uninstall node: This will prompt you to confirm before uninstalling the node. If you confirm, it will uninstall the node using the curl command.

Exit: This will exit the script and stop the program.

#### If you encounter issues and need to reset, use:
```bash
aioS-cli kill && aioS-cli start
``` 

### Common Issues 🚧

-   **Illegal instruction (core dumped)**:
    
    -   This error usually happens due to insufficient cores or an incompatible kernel. To resolve this, it's recommended to use a more powerful server with the necessary system specifications (especially for CPU and RAM).
