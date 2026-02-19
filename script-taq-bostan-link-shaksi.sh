# [این کد را در فایلی با نام script-taq-bostan-link-shaksi.sh ذخیره کنید]
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
  # ... (بقیه آرت حذف شد برای کوتاهی پاسخ، در فایل اصلی بماند)
  echo -e "Developed by Parsa | Customized for Offline Use"
  echo -e "\033[0m"
}

# ایجاد دستور میان‌بر برای فراخوانی راحت‌تر
create_shortcut() {
  if ! grep -q "alias taq-bostan=" ~/.bashrc; then
    echo "alias taq-bostan='bash /usr/local/bin/script-taq-bostan-link-shaksi.sh'" >> ~/.bashrc
    sudo cp "$0" /usr/local/bin/script-taq-bostan-link-shaksi.sh
    sudo chmod +x /usr/local/bin/script-taq-bostan-link-shaksi.sh
    source ~/.bashrc 2>/dev/null
  fi
}

print_menu() {
  draw_green_line
  echo -e "${GREEN}|${RESET}              ${BOLD_GREEN}TAQ-BOSTAN Personal Menu${RESET}               ${GREEN}|${RESET}"
  draw_green_line
  echo -e "${GREEN}|${RESET} ${BLUE}1)${RESET} Create Hysteria2 Tunnel (Bayan Link)            ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${YELLOW}2)${RESET} Create local IPv6 with Sit                      ${GREEN}|${RESET}"
  echo -e "${GREEN}|${RESET} ${MAGENTA}3)${RESET} Create local IPv6 with Wireguard                ${GREEN}|${RESET}"
  # ... بقیه گزینه‌ها
  draw_green_line
}

execute_option() {
  local choice="$1"
  case "$choice" in
    1)
      bash <(curl -Ls https://bayanbox.ir/download/6150559480873366137/hysteria.sh)
      ;;
    2)
      bash <(curl -Ls https://bayanbox.ir/download/99094217194741185/sit.sh)
      ;;
    3)
      bash <(curl -Ls https://bayanbox.ir/download/7225823580627238025/wireguard.sh)
      ;;
    # ... بقیه موارد مشابه فایل اصلی
  esac
}

create_shortcut
print_art
print_menu
read -p "Select an option [1-7]: " user_choice
execute_option "$user_choice"
