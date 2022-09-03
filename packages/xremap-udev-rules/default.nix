{ lib, writeTextDir }:

writeTextDir "lib/udev/rules.d/99-input.rules"
  ''
    KERNEL=="uinput", GROUP="input", MODE="0660"
  ''
