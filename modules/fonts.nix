{ pkgs, ... }: 
{
  fonts = {
    fontconfig.enable = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "IosevkaTerm" ]; })
    ];
  };
}
