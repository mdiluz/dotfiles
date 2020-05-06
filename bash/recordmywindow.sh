#! /bin/bash
# Use interactive selection to record a specific window using recordmydesktop
recordmydesktop --windowid `xwininfo -display :0 | grep 'id: 0x' | grep -Eo '0x[a-z0-9]+'`
