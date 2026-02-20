#!/bin/bash

# تعریف رنگ‌ها
GREEN="\e[32m"
BOLD_GREEN="\e[1;32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
WHITE="\e[37m"
RED="\e[31m"
RESET="\e[0m"

# تابع کشیدن خط جداکننده
draw_green_line() {
  echo -e "${GREEN}+--------------------------------------------------------+${RESET}"
}

# نمایش لوگو و اطلاعات شخصی‌سازی شده
print_art() {
  echo -e "\033[1;32m"
  echo -e "@@@@@@@   @@@@@@    @@@@@@                                 "
  echo -e "@@@@@@@  @@@@@@@@  @@@@@@@@                                "
  echo -e "  @@!    @@!  @@@  @@!  @@@                                "
  echo -e "  !@!    !@!  @!@  !@!  @!@                                "
  echo -e "  @!!    @!@!@!@!  @!@  !@!                                "
  echo -e "  !!!    !!!@!!!!  !@!  !!!                                "
  echo -e "  !!:    !!:  !!!  !!:!!:!:                                "
  echo -e "  :!:    :!:  !:!  :!: :!:                                 "
  echo -e "   ::    ::   :::  ::::: :!                                "
  echo -e "   :      :   : :   : :  :::                               "
  echo -e "@@@@@@@    @@@@@@    @@@@@@  @@@@@@@   @@@@@@   @@@  @@@   "
  echo -e "@@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@  @@@@@@@@  @@@@ @@@   "
  echo -e "@@!  @@@  @@!  @@@  !@@        @@!    @@!  @@@  @@!@!@@@   "
  echo -e "!@   @!@  !@!  @!@  !@!        !@!    !@!  @!@  !@!!@!@!   "
  echo -e "@!@!@!@   @!@  !@!  !!@@!!     @!!    @!@!@!@!  @!@ !!@!   "
  echo -e "!!!@!!!!  !@!  !!!   !!@!!!    !!!    !!!@!!!!  !@!  !!!   "
  echo -e "!!:  !!!  !!:  !!!       !:!   !!:    !!:  !!!  !!:  !!!   "
  echo -e ":!:  !:!  :!:  !:!      !:!    :!:    :!:  !:!  :!:  !:!   "
  echo -e " :: ::::  ::::: ::  :::: ::     ::    ::   :::   ::   ::   "
  echo -e ":: : ::    : :  :   :: : :      :      :   : :  ::    :    "
  echo -e "\033[0m"
  echo -e "\033[1;33m=========================================================="
  echo -e "GitHub Version: 2amir563 | Personal Tunnel Manager"
  echo -e "\033[0m"
}

# ایجاد میان‌بر taq-bostan برای فراخوانی سریع بدون نیاز به لینک
create_shortcut() {
  local script_path="/usr/local/bin/taq-bostan-github.sh"
  sudo cp "$0" "$script_path" 2>/dev/null
  sudo chmod +x "$script_path" 2>/dev/null
  
  if ! grep -q "alias taq-bostan=" ~/.bashrc; then
    echo "alias taq-bostan='bash $script_path'" >> ~/.bashrc
    source ~/.bashrc 2>/dev/null
  fi
}

# منوی انتخاب
print_menu() {
  draw_green_line
  echo -e "${GREEN}|${RESET}            ${BOLD_GREEN}TAQ-BOSTAN GitHub Personal Menu${RESET}           ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}1)${RESET} Create Hysteria2 Tunnel (Your GitHub)           ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}2)${RESET} Create local IPv6 with Sit (Your GitHub)        ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}3)${RESET} Create local IPv6 with Wireguard (Your GitHub)  ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}4)${RESET} Delete Hysteria tunnel                          ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}5)${RESET} Delete local IPv6 with Sit                      ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}6)${RESET} Delete local IPv6 with Wireguard                ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${RED}7)${RESET} Hysteria Tunnel Speedtest                       ${GREEN}|${RESET}"
  draw_green_line
}

# اجرای دستورات بر اساس مخزن شخصی شما
execute_option() {
  local choice="$1"
  local base_url="https://raw.githubusercontent.com/2amir563/shaksi-test--taqbostan/main/hysteria.sh"
  
  case "$choice" in
    1)
      echo -e "${CYAN}Executing Hysteria2 Setup from your GitHub Repo...${RESET}"
      bash <(curl -Ls ${base_url}/hysteria-balink-github-shakhsi.sh)
      ;;
    2)
      echo -e "${CYAN}Executing SIT Tunnel Setup from your GitHub Repo...${RESET}"
      bash <(curl -Ls ${base_url}/sit.sh)
      ;;
    3)
      echo -e "${CYAN}Executing WireGuard Setup from your GitHub Repo...${RESET}"
      bash <(curl -Ls ${base_url}/wireguard.sh)
      ;;
    4)
      sudo systemctl daemon-reload 2>/dev/null
      for i in {1..9}; do sudo systemctl disable hysteria$i 2>/dev/null; done
      sudo rm /etc/hysteria/*.yaml 2>/dev/null
      echo -e "${GREEN}Hysteria tunnels deleted.${RESET}"
      ;;
    5)
      for i in {1..8}; do
        sudo rm /etc/netplan/pdtun$i.yaml /etc/systemd/network/tun$i.network 2>/dev/null
      done
      sudo netplan apply
      echo -e "${GREEN}SIT Tunnel deleted.${RESET}"
      ;;
    6)
      sudo wg-quick down TAQBOSTANwg 2>/dev/null
      sudo systemctl disable wg-quick@TAQBOSTANwg 2>/dev/null
      sudo rm /etc/wireguard/TAQBOSTANwg.conf 2>/dev/null
      echo -e "${GREEN}Wireguard deleted.${RESET}"
      ;;
    7)
      read -p "Enter server number for speedtest: " server_number
      /usr/local/bin/hysteria -c /etc/hysteria/iran-config${server_number}.yaml speedtest
      ;;
    *)
      echo -e "${RED}Invalid option.${RESET}"
      exit 1
      ;;
  esac
}

# شروع اسکریپت
create_shortcut
print_art
print_menu
read -p "$(echo -e "${WHITE}Select an option [1-7]: ${RESET}")" user_choice
execute_option "$user_choice"
