#!/bin/bash
# TAQ-BOSTAN Main Menu - GitHub Personal Version

GREEN="\e[32m"
BOLD_GREEN="\e[1;32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
WHITE="\e[37m"
RED="\e[31m"
RESET="\e[0m"

draw_green_line() {
  echo -e "${GREEN}+--------------------------------------------------------+${RESET}"
}

print_art() {
  echo -e "\033[1;32m"
  echo -e "@@@@@@@   @@@@@@    @@@@@@                                 "
  echo -e "@@@@@@@  @@@@@@@@  @@@@@@@@                                "
  # ... (بقیه آرت در فایل اصلی موجود است)
  echo -e "Developed by Parsa | GitHub Personal Branch: 2amir563"
  echo -e "\033[0m"
}

create_shortcut() {
  local script_path="/usr/local/bin/taq-bostan-shakhsi.sh"
  sudo cp "$0" "$script_path"
  sudo chmod +x "$script_path"
  if ! grep -q "alias taq-bostan=" ~/.bashrc; then
    echo "alias taq-bostan='bash $script_path'" >> ~/.bashrc
    source ~/.bashrc 2>/dev/null
  fi
}

print_menu() {
  draw_green_line
  echo -e "${GREEN}|${RESET}           ${BOLD_GREEN}TAQ-BOSTAN GitHub Personal Menu${RESET}            ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}1)${RESET} Create Hysteria2 Tunnel (GitHub Link)           ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}2)${RESET} Create local IPv6 with Sit (GitHub Link)        ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}3)${RESET} Create local IPv6 with Wireguard (GitHub Link)  ${GREEN}|${RESET}"
  # ... بقیه گزینه‌ها
  draw_green_line
}

execute_option() {
  local choice="$1"
  case "$choice" in
    1)
      # ارجاع به فایل جدید شما در گیت‌هاب
      bash <(curl -Ls https://raw.githubusercontent.com/2amir563/shaksi-test--taqbostan/main/hysteria-balink-github-shakhsi.sh)
      ;;
    2)
      bash <(curl -Ls https://raw.githubusercontent.com/2amir563/shaksi-test--taqbostan/main/sit.sh)
      ;;
    3)
      bash <(curl -Ls https://raw.githubusercontent.com/2amir563/shaksi-test--taqbostan/main/wireguard.sh)
      ;;
    4)
      sudo systemctl daemon-reload 2>/dev/null
      for i in {1..9}; do sudo systemctl disable hysteria$i 2>/dev/null; done
      sudo rm /etc/hysteria/*.yaml 2>/dev/null
      echo "Hysteria tunnels deleted."
      ;;
    7)
      read -p "Enter server number: " s_num
      /usr/local/bin/hysteria -c /etc/hysteria/iran-config${s_num}.yaml speedtest
      ;;
    *) exit 0 ;;
  esac
}

create_shortcut
print_art
print_menu
read -p "Select option [1-7]: " user_choice
execute_option "$user_choice"
