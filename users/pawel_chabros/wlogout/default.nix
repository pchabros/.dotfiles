{ pkgs, ... }:
let icons = "${pkgs.wlogout}/share/wlogout/icons";

in {
  programs.wlogout = {
    enable = true;
    style = ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(46, 52, 64, 0.9);
      }
      button {
      	background-color: #2e3440;
      	border-style: solid;
      	border-width: 0px;
      	border-radius: 0;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      	color: #5e81ac;
      }

      button:focus, button:active, button:hover {
      	background-color: #4c566a;
      	color: #81a1c1;
      	outline-style: none;
      }
      #lock {
        background-image: image(url("${icons}/lock.png"));
      }
      #logout {
        background-image: image(url("${icons}/logout.png"));
      }
      #suspend {
        background-image: image(url("${icons}/suspend.png"));
      }
      #hibernate {
        background-image: image(url("${icons}/hibernate.png"));
      }
      #shutdown {
        background-image: image(url("${icons}/shutdown.png"));
      }
      #reboot {
        background-image: image(url("${icons}/reboot.png"));
      }
    '';
  };
}
