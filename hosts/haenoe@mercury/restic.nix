{ ... }:
{
  services.restic.backups = {
    remote = {
      initialize = true;
      paths = [ "/home/haenoe" ];
      extraBackupArgs = [ "--exclude-caches" ];
      repositoryFile = "sftp:u350984@u350984.your-storagebox.de:/test-backup-nixos";
      passwordFile = "/home/haenoe/password-file";
      backupCleanupCommand = ''
        echo 'exit-code' $EXIT_CODE
        echo 'exit-status' $EXIT_STATUS
        # curl https://uptimekuma.saturn.haenoe.party/api/push/vb3ZXK6W8i?status=up&msg=OK&ping=
      '';
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
