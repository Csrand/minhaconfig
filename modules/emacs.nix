{ pkgs, inputs, ... }:

{
  # Configuração básica do Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # Versão padrão
  };

  # Configuração do Doom Emacs
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./dot-doom;  # Pasta com sua configuração
    
    # Configuração inicial recomendada
    init = ''
      (setq doom-font "Fira Code-14")
      (setq doom-theme 'doom-one)
    '';
    
    # Pacotes essenciais para começar
    packages = with inputs.doom-emacs.packages; [
      evil
      org
      org-roam
      magit
    ];
  };

  # Atalho para iniciar Emacs como serviço
  services.emacs = {
    enable = true;
    client.enable = true;
  };

  # Variáveis de ambiente úteis
  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };
}
