#!/usr/bin/env bash
# Ensure Flatpak overrides are set for native window layout compatibility

# Spotify UI / Titlebar fix for GNOME Wayland
flatpak override --user --socket=x11 com.spotify.Client
flatpak override --user --nosocket=wayland com.spotify.Client

echo "Flatpak window decoration overrides applied successfully!"
