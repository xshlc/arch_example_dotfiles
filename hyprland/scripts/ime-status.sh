#!/bin/bash
case "$(fcitx5-remote)" in
  2) echo "KR" ;;
  1) echo "EN" ;;
  0) echo "US" ;;
esac

