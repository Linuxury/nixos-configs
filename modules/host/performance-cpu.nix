{ lib, ... }:

{
  #########################
  # CPU / VM performance tweaks (desktop/gaming focus)
  #########################

  # Lower swappiness – prefer RAM over swap on desktops with plenty of memory
  boot.kernel.sysctl."vm.swappiness" = 10;

  # Other common useful sysctls for gaming/performance desktops
  boot.kernel.sysctl = {
    # Increase inotify watches (helps with large projects, IDEs, games)
    "fs.inotify.max_user_watches" = 524288;

    # Improve network performance
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_slow_start_after_idle" = 0;

    # Reduce latency
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };

  # Optional: Enable huge pages (good for some games/apps)
  # boot.kernelParams = [ "hugepages=4096" ];
}
