{
  programs.qutebrowser = {
    enable = true;
    settings = {
      auto_save.session = true;
      colors.webpage = {
        preferred_color_scheme = "dark";
        darkmode.enabled = true;
      };
      fonts.default_family = [ "JetBrainsMono Nerd Font" ];
      statusbar = {
        show = "always";
        position = "bottom";
        widgets = [ "url" "keypress" ];
      };
      tabs = {
        favicons.scale = 1.1;
        indicator.width = 0;
        max_width = 200;
        title.format_pinned = "";
      };
    };
    enableDefaultBindings = false;
    keyBindings = {
      normal = {
        "o" = "cmd-set-text -s :open";
        "O" = "cmd-set-text -s :open -t";
        "j" = "back";
        "k" = "scroll  down";
        "l" = "scroll up";
        ";" = "forward";
        "K" = "tab-next";
        "L" = "tab-prev";
        "gg" = "scroll-to-perc 0";
        "G" = "scroll-to-perc";
        "v" = "mode-enter caret";
        "V" = "mode-enter caret ;; selection-toggle --line";
        "<Alt-Shift-K>" = "tab-move +";
        "<Alt-Shift-L>" = "tab-move -";
        "Q" = "tab-close";
        "D" = "devtools bottom";
        "Ba" = "bookmark-add";
        "Bl" = "bookmark-list";
        "Pa" = "tab-pin";
        "f" = "hint";
        "<Alt-i>" = "hint inputs";
        "<Alt-Shift-i>" = "hint inputs --first";
        "<Alt-o>" = "hint links";
        "<Alt-b>" = "hint buttons";
        ":" = "cmd-set-text :";
        "/" = "cmd-set-text /";
        "n" = "search-next";
        "N" = "search-prev";
        "." = "cmd-repeat-last";
        "r" = "reload -f";
        "u" = "undo";
        "yy" = "yank";
        "yu" = "yank url";
        "<Return>" = "selection-follow";
      };
      caret = {
        "j" = "move-to-prev-char";
        "k" = "move-to-next-line";
        "l" = "move-to-prev-line";
        ";" = "move-to-next-char";
        "K" = "scroll down";
        "L" = "scroll up";
        "o" = "selection-reverse";
        "v" = "selection-toggle";
        "w" = "move-to-next-word";
        "y" = "yank selection";
        "$" = "move-to-end-of-line";
        "0" = "move-to-start-of-line";
        "<Ctrl-Space>" = "selection-drop";
        "<Escape>" = "mode-leave";
        "<Return>" = "yank selection";
        "<Space>" = "selection-toggle";
        "V" = "selection-toggle --line";
        "Y" = "yank selection -s";
        "[" = "move-to-start-of-prev-block";
        "]" = "move-to-start-of-next-block";
        "b" = "move-to-prev-word";
        "c" = "mode-enter normal";
        "e" = "move-to-end-of-word";
        "gg" = "move-to-start-of-document";
        "G" = "move-to-end-of-document";
      };
      command = {
        "<Escape>" = "mode-leave";
        "<Return>" = "command-accept";
        "<Tab>" = "completion-item-focus next";
        "<Down>" = "completion-item-focus --history next";
        "<Up>" = "completion-item-focus --history prev";
      };
      hint = {
        "<Escape>" = "mode-leave";
        "<Return>" = "hint-follow";
      };
      prompt = {
        "<Escape>" = "mode-leave";
        "<Return>" = "prompt-accept";
      };
      yesno = {
        "<Escape>" = "mode-leave";
        "<Return>" = "prompt-accept";
        "N" = "prompt-accept --save no";
        "Y" = "prompt-accept --save yes";
        "n" = "prompt-accept no";
        "y" = "prompt-accept yes";
      };
      insert = { "<Escape>" = "mode-leave"; };
    };
    extraConfig = ''
      ${builtins.readFile ./config/nord-qutebrowser.py}
      c.tabs.padding = {'bottom': 12, 'left': 10, 'right': 6, 'top': 12}
      c.statusbar.padding = {'top': 6, 'bottom': 6, 'left': 4, 'right': 4}
      c.hints.selectors = {
        "all": [
          'a',
          'area',
          'textarea',
          'select',
          'input:not([type="hidden"])',
          'button',
          'frame',
          'iframe',
          'img',
          'link',
          'summary',
          '[contenteditable]:not([contenteditable="false"])',
          '[onclick]',
          '[onmousedown]',
          '[role="link"]',
          '[role="option"]',
          '[role="button"]',
          '[role="tab"]',
          '[role="checkbox"]',
          '[role="menuitem"]',
          '[role="menuitemcheckbox"]',
          '[role="menuitemradio"]',
          '[role="treeitem"]',
          '[aria-haspopup]',
          '[ng-click]',
          '[ngClick]',
          '[data-ng-click]',
          '[x-ng-click]',
          '[tabindex]:not([tabindex="-1"])',
        ],
        "buttons": [
          'button',
          '[role="button"]',
        ],
        "links": [
          'a[href]',
          'area[href]',
          'link[href]',
          '[role="link"]',
          '[href]',
        ],
        "images": [
          'img',
        ],
        "media": [
          'audio',
          'img',
          'video',
        ],
        "url": [
          '[src]',
          '[href]',
        ],
        "inputs": [
          'input[type="text"]',
          'input[type="date"]',
          'input[type="datetime-local"]',
          'input[type="email"]',
          'input[type="month"]',
          'input[type="number"]',
          'input[type="password"]',
          'input[type="search"]',
          'input[type="tel"]',
          'input[type="time"]',
          'input[type="url"]',
          'input[type="week"]',
          'input:not([type])',
          '[contenteditable]:not([contenteditable="false"])',
          'textarea',
        ],
      };
    '';
  };
}
