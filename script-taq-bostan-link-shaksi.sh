#!/bin/bash

# تعریف رنگ‌ها برای خروجی زیباتر
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

# تابع نمایش لوگوی پروژه
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
  echo -e "Developed by Parsa | Optimized for Offline/Personal Use"
  echo -e "\033[0m${RED}Sponsored by DigitalVPS.ir${RED}${RESET}"
  echo -e "\033[1;33mLove Iran :)"
  echo -e "\033[0m"
}

# --- بخش جدید: ایجاد دستور میان‌بر taq-bostan ---
create_shortcut() {
  local script_path="/usr/local/bin/taq-bostan-script.sh"
  # کپی کردن خودِ این اسکریپت در مسیر سیستم
  sudo cp "$0" "$script_path"
  sudo chmod +x "$script_path"
  
  # اضافه کردن alias به فایل bashrc اگر وجود نداشته باشد
  if ! grep -q "alias taq-bostan=" ~/.bashrc; then
    echo "alias taq-bostan='bash $script_path'" >> ~/.bashrc
    colorEcho "Shortcut 'taq-bostan' created. Please run 'source ~/.bashrc' or restart terminal." green
  fi
}

# تابع نمایش منو
print_menu() {
  draw_green_line
  echo -e "${GREEN}|${RESET}              ${BOLD_GREEN}TAQ-BOSTAN Personal Menu${RESET}               ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}1)${RESET} Create Hysteria2 Tunnel (Personal Link)         ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}2)${RESET} Create local IPv6 with Sit (Bayan Link)         ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}3)${RESET} Create local IPv6 with Wireguard (Bayan Link)   ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}4)${RESET} Delete Hysteria tunnel                          ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}5)${RESET} Delete local IPv6 with Sit                      ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}6)${RESET} Delete local IPv6 with Wireguard                ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${RED}7)${RESET} Hysteria Tunnel Speedtest                       ${GREEN}|${RESET}"
  draw_green_line
}

# تابع اجرای گزینه‌ها با لینک‌های شخصی بیان شما
execute_option() {
  local choice="$1"
  case "$choice" in
    1)
      echo -e "${CYAN}Executing Hysteria2 Setup from your personal link...${RESET}"
      bash <(curl -Ls https://bayanbox.ir/download/419507915507343708/hysteria-balink-shaksi.sh)
      ;;
    2)
      echo -e "${CYAN}Executing SIT Tunnel Setup...${RESET}"
      bash <(curl -Ls https://bayanbox.ir/download/99094217194741185/sit.sh)
      ;;
    3)
      echo -e "${CYAN}Executing WireGuard Setup...${RESET}"
      bash <(curl -Ls https://bayanbox.ir/download/7225823580627238025/wireguard.sh)
      ;;
    4)
      # منطق حذف مشابه فایل اصلی
      sudo systemctl daemon-reload 2>/dev/null
      for i in {1..9}; do sudo systemctl disable hysteria$i 2>/dev/null; done
      sudo systemctl disable hysteria 2>/dev/null
      sudo rm /etc/hysteria/*.yaml 2>/dev/null
      echo -e "${GREEN}Hysteria tunnel deleted.${RESET}"
      ;;
    5)
      # حذف SIT
      for i in {1..8}; do
        sudo rm /etc/netplan/pdtun$i.yaml /etc/systemd/network/tun$i.network 2>/dev/null
      done
      sudo netplan apply
      echo -e "${GREEN}SIT Tunnel deleted.${RESET}"
      ;;
    6)
      # حذف WireGuard
      sudo wg-quick down TAQBOSTANwg 2>/dev/null
      sudo systemctl disable wg-quick@TAQBOSTANwg 2>/dev/null
      sudo rm /etc/wireguard/TAQBOSTANwg.conf 2>/dev/null
      echo -e "${GREEN}Wireguard deleted.${RESET}"
      ;;
    7)
      read -p "Enter foreign server number for speedtest: " server_number
      /usr/local/bin/hysteria -c /etc/hysteria/iran-config${server_number}.yaml speedtest
      ;;
    *)
      echo -e "${RED}Invalid option.${RESET}"
      exit 1
      ;;
  esac
}

# اجرای توابع
create_shortcut
print_art
print_menu
read -p "$(echo -e "${WHITE}Select an option [1-7]: ${RESET}")" user_choice
execute_option "$user_choice"
