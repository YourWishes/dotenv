#!/bin/bash

# Disable the workspaces
qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.rows 1
qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.removeDesktop $(qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.current)
# TODO: Remove the tray icon

