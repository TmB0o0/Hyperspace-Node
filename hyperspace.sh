#!/bin/bash

set -e  # Остановить выполнение при ошибках

# Очистка экрана
clear

# Цвета
WHITE='\033[1;37m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

# Логотип и ссылки
lines=(
  "\e[1;36m+-----------------------------------------------------------------------------------------------------------+\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m##  ###  #######  ######   #######  #######  #######  ######   #######  ##  ##   #######  ######         \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m### ###  ##   ##  ##  ##   ##       ##         ###    ##  ##     ###    ##  ##   ##       ##  ##         \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m#######  ##   ##  ##  ##   ##       #######    ###    ##  ##     ###    ## ##    ##       ##  ##         \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m## ####  ##  ###  ### ###  #######       ##    ###    #######    ###    #######  #######  #######        \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m##  ###  ##  ###  ### ###  ###      ###  ##    ###    ### ###    ###    ##  ###  ###      ### ###        \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m##  ###  ##  ###  ### ###  # #      ###  ##    ###    ### ###    ###    ##  ###  # #      ### ###        \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  \e[1;33m##  ###  #######  #######  #######  #######    ###    ### ###  #######  ##  ###  #######  ### ###        \e[1;36m|\e[0m"
  "\e[1;36m+-----------------------------------------------------------------------------------------------------------+\e[0m"
  "\e[1;36m|\e[0m                                                                                                           \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  🔗 \e[1;32mFollow us on Twitter:\e[0m \e[4;34mhttps://x.com/TmBO0o\e[0m 🐦                                                    \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  💻 \e[1;32mGitHub Repository:\e[0m \e[4;34mhttps://github.com/TmB0o0\e[0m 📁                                                  \e[1;36m|\e[0m"
  "\e[1;36m|\e[0m  📖 \e[1;32mGitBook Guide:\e[0m \e[4;34mhttps://tmb.gitbook.io/nodeguidebook/\e[0m 📚                                          \e[1;36m|\e[0m"
  "\e[1;36m+-----------------------------------------------------------------------------------------------------------+\e[0m"
)

for line in "${lines[@]}"; do
  echo -e "$line"
  sleep 0.05
done

# Проверка наличия screen
install_screen() {
    if ! command -v screen &> /dev/null; then
        echo -e "${YELLOW}Installing 'screen' package...${RESET}"
        apt-get update && apt-get install -y screen
        echo -e "${GREEN}Screen installed successfully.${RESET}"
    else
        echo -e "${GREEN}Screen is already installed.${RESET}"
    fi
}

# Установка ноды
install_node() {
    install_screen
    screen -S hyperspace -dm bash -c "
    source /root/.bashrc
    aios-cli start
    "

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Node process started in 'hyperspace' screen session.${RESET}"
    else
        echo -e "${RED}Error starting process in screen.${RESET}"
        exit 1
    fi

    source /root/.bashrc
    aios-cli models add hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf
    echo -e "${CYAN}Paste your PEM file content, then press Ctrl+O, Enter, Ctrl+X to save and exit.${RESET}"
    nano .pem
    aios-cli hive import-keys ./.pem
    aios-cli hive login
    aios-cli hive connect
    aios-cli hive select-tier 5
    aios-cli hive select-tier 3
    echo -e "${GREEN}Node successfully installed and connected!${RESET}"
    sleep 2
}

# Проверка очков
check_points() {
    aios-cli hive points
    sleep 2
}

# Обновление ноды
update_node() {
    aios-cli version
    sleep 2
}

# Логи
show_logs() {
    if screen -list | grep -q "hyperspace"; then
        echo -e "${CYAN}Connecting to 'hyperspace' screen session...${RESET}"
        screen -r hyperspace
    else
        echo -e "${RED}Screen session 'hyperspace' not found.${RESET}"
    fi
    sleep 2
}

# Удаление ноды
uninstall_node() {
    read -p "Are you sure you want to uninstall the node? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        curl https://download.hyper.space/api/uninstall | bash
        sleep 2
    else
        echo -e "${YELLOW}Uninstallation cancelled.${RESET}"
        sleep 2
    fi
}

# Главное меню
while true; do
    echo -e "\n${WHITE}╔════════════════════════════════════════════╗${RESET}"
    echo -e "${WHITE}║            NODE MANAGEMENT MENU            ║${RESET}"
    echo -e "${WHITE}╚════════════════════════════════════════════╝${RESET}"
    echo -e "${WHITE}1) Install node${RESET}"
    echo -e "${WHITE}2) Check points${RESET}"
    echo -e "${WHITE}3) Update node${RESET}"
    echo -e "${WHITE}4) Show logs${RESET}"
    echo -e "${WHITE}5) Uninstall node${RESET}"
    echo -e "${WHITE}6) Exit${RESET}"
    echo -ne "${CYAN}Select an option: ${RESET}"
    read -r choice

    case $choice in
        1) install_node ;;
        2) check_points ;;
        3) update_node ;;
        4) show_logs ;;
        5) uninstall_node ;;
        6) exit 0 ;;
        *) echo -e "${RED}Invalid option! Try again.${RESET}" ;;
    esac
done
