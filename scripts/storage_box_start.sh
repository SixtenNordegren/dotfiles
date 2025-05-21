mkdir -p ~/storagebox

sshfs -p23 \
  u462100@u462100.your-storagebox.de: \
  ~/storagebox \
  -o reconnect,compression=yes,ServerAliveInterval=30
