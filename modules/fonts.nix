{ pkgs, ... }: 
{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "IosevkaTerm" ]; })
    ];
  };
}
