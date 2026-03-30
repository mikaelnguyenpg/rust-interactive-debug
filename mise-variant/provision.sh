#!/usr/bin/env bash
# ~/.dotfiles/distrobox/provision.sh
set -e

# ─── System packages ────────────────────────────────────────────────────────
sudo apt-get update -qq
sudo apt-get install -y \
  vim nano curl wget git zsh \
  build-essential pkg-config \
  ca-certificates unzip libssl-dev \
  lldb gdb openssh-server

# # ─── PATH ───────────────────────────────────────────────────────────────────
# export PATH="$HOME/.local/bin:$PATH"

# # ─── Mise ───────────────────────────────────────────────────────────────────
# curl https://mise.run | sh

# # ─── Patch .zshrc — append thay vì overwrite ────────────────────────────────
# # Tạo .zshrc mặc định của zsh nếu chưa có
# if [ ! -f ~/.zshrc ]; then
#   zsh -c 'exit'   # zsh tự tạo .zshrc mặc định khi chạy lần đầu
# fi

# # ─── Added by provision.sh ───────────────────────────────────────────────────
# # Chỉ append nếu chưa có (idempotent)
# if ! grep -q "mise activate" ~/.zshrc; then
#   cat >> ~/.zshrc << 'EOF'

# export PATH="$HOME/.local/bin:$PATH"

# if [[ -x "$HOME/.local/bin/mise" ]]; then
#   eval "$($HOME/.local/bin/mise activate zsh)"
# fi
# EOF
# fi

# # ─── Trust mise configs trong /data ──────────────────────────────────────────
# mkdir -p ~/.config/mise
# cat > ~/.config/mise/config.toml << 'MISE'
# [settings]
# trusted_config_paths = ["/data"]
# MISE

echo "✓ Provision complete"
