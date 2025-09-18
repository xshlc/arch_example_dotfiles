#!/bin/bash
case "$(fcitx5-remote)" in
  2) echo "한" ;;
  1) echo "en" ;;
  0) echo "US" ;;
esac

