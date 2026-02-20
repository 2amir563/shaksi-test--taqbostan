#!/bin/bash

# --- بخش هوشمند برای اجرای سریع (بدون نیاز به دانلود مجدد) ---
# اگر اسکریپت از طریق curl اجرا شده باشد، محتوای در حال اجرا را در فایل مقصد ذخیره می‌کند
if [[ "$0" != "/usr/local/bin/taq-bostan" ]]; then
    if [[ -f "$0" ]]; then
        sudo cp "$0" /usr/local/bin/taq-bostan
    else
        cat "$0" | sudo tee /usr/local/bin/taq-bostan > /dev/null
    fi
    sudo chmod +x /usr/local/bin/taq-bostan
    if ! grep -q "alias taq-bostan=" ~/.bashrc; then
        echo "alias taq-bostan='bash /usr/local/bin/taq-bostan'" >> ~/.bashrc
        export PATH="$PATH:/usr/local/bin"
    fi
fi

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

# --- لینک‌های استخراج شده از کد شما (مخصوص بیان) ---
LINK_HYSTERIA="https://bayanbox.ir/download/8975390779774351326/hysteria.sh"
LINK_SIT="https://bayanbox.ir/download/123069150025178696/sit.sh"
LINK_WG="https://bayanbox.ir/download/587979313587847990/wireguard.sh"

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
}

print_menu() {
  draw_green_line
  echo -e "${GREEN}|${RESET}            ${BOLD_GREEN}TAQ-BOSTAN Main Menu (Bayan)${RESET}              ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}1)${RESET} Create Hysteria2 Tunnel                         ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}2)${RESET} Create local IPv6 with Sit                      ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}3)${RESET} Create local IPv6 with Wireguard                ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}4)${RESET} Delete Hysteria tunnel                          ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}5)${RESET} Delete local IPv6 with Sit                      ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}6)${RESET} Delete local IPv6 with Wireguard                ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${RED}7)${RESET} Hysteria Tunnel Speedtest                       ${GREEN}|${RESET}"
  draw_green_line
}

execute_option() {
  local choice="$1"
  case "$choice" in
    1)
      echo -e "${CYAN}Executing Hysteria Setup...${RESET}"
      bash <(curl -Ls "$LINK_HYSTERIA")
      ;;
    2)
      echo -e "${CYAN}Executing local IPv6 with Sit...${RESET}"
      bash <(curl -Ls "$LINK_SIT")
      ;;
    3)
      echo -e "${CYAN}Executing local IPv6 with Wireguard...${RESET}"
      bash <(curl -Ls "$LINK_WG")
      ;;
    4)
       echo -e "${CYAN}Deleting Hysteria tunnel...${RESET}"
       sudo systemctl daemon-reload
       for i in {1..9}; do
         sudo systemctl stop hysteria$i 2>/dev/null
         sudo systemctl disable hysteria$i 2>/dev/null
       done
       sudo rm /etc/hysteria/*.yaml 2>/dev/null
       echo -e "${GREEN}Hysteria tunnel successfully deleted.${RESET}"
       ;;
    5)
       echo -e "${CYAN}Deleting local IPv6 with Sit...${RESET}"
       for i in {1..8}; do
         sudo rm /etc/netplan/pdtun$i.yaml 2>/dev/null
         sudo rm /etc/systemd/network/tun$i.network 2>/dev/null
         sudo rm /etc/netplan/pdtun.yaml 2>/dev/null
         sudo rm /etc/systemd/network/tun0.network 2>/dev/null
       done
       sudo netplan apply 
       sudo systemctl restart systemd-networkd
       echo -e "${GREEN}Local IPv6 with Sit successfully deleted.${RESET}"
       read -p "Do you want to reboot now? [y/N]: " REBOOT_CHOICE
       if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
         sudo shutdown -r now
       fi
       ;;
    6)
       echo -e "${CYAN}Deleting local IPv6 with Wireguard...${RESET}"
       sudo wg-quick down TAQBOSTANwg 2>/dev/null
       sudo systemctl disable wg-quick@TAQBOSTANwg 2>/dev/null
       sudo rm /etc/wireguard/TAQBOSTANwg.conf 2>/dev/null
       echo -e "${GREEN}Local IPv6 with Wireguard successfully deleted.${RESET}"
       read -p "Do you want to reboot now? [y/N]: " REBOOT_CHOICE
       if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
         sudo shutdown -r now
       fi
       ;;
    7)
       read -p "For which foreign server number do you want to run the speedtest? " server_number
       /usr/local/bin/hysteria -c /etc/hysteria/iran-config${server_number}.yaml speedtest
       ;;
    *)
      exit 0
      ;;
  esac
}

# اجرای برنامه
print_art
print_menu
read -p "Please select an option: " user_choice
execute_option "$user_choice"
