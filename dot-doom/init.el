;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       vertico

       :ui
       doom
       doom-dashboard
       (modeline +light)
       ophints

       :editor
       (evil +everywhere)
       file-templates
       fold

       :emacs
       dired
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       (magit +forge)
       direnv

       :lang
       emacs-lisp
       (org +roam2 +pretty)
       nix

       :app
       calendar

       :config
       (default +bindings +smartparens))
