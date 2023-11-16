{ pkgs, config, ... }:
{
  age.secrets.repository-key = {
    file = ./repository-key.age;
    owner = "haenoe";
  };

  services.restic.backups = {
    remote = {
      initialize = true;
      paths = [
        "/home/haenoe"
      ];
      exclude = [
        "/home/haenoe/backup"
        "/home/haenoe/isos"
      ];
      extraBackupArgs = [ "--exclude-caches" ];
      user = "haenoe";
      repository = "sftp:u350984-sub4@storagebox:/home/system-backup";
      passwordFile = config.age.secrets.repository-key.path;
      backupCleanupCommand = ''
        UPTIME_KUMA_STATUS="down"

        if [ "$EXIT_CODE" = "0" ]; then
          UPTIME_KUMA_STATUS="up"
        fi

        ${pkgs.curl}/bin/curl --fail --no-progress-meter --retry 3 "https://uptimekuma.saturn.haenoe.party/api/push/vb3ZXK6W8i?status=$uptime_kuma_status&msg=OK&ping="
      '';
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
