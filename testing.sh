#!/bin/bash

# Disable the workspaces
qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.rows 1
qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.removeDesktop $(qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.current)
# TODO: Remove the tray icon

# Enable touch points
if [[ $(qdbus org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded touchpoints) -eq 'false' ]]; then
  qdbus org.kde.KWin /Effects org.kde.kwin.Effects.isEffectLoaded touchpoints
  qdbus org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect touchpoints
fi