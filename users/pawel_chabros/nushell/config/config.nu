$env.config = {
  edit_mode: vi
  history: {
    max_size: 100000
  }
}

alias gfa = git fetch --all
alias gp = git push
alias gpf = git push --force-with-lease
alias gpu = git push --set-upstream origin (git branch --show-current)
alias gpl = git pull
alias gm = git merge
alias gss = git status -s
alias gl = git log --oneline --decorate
alias gt = git log --all --graph --decorate --oneline
alias lg = lazygit

alias dcb = docker compose build
alias dcu = docker compose up
def dcr [container: string, command: string] {
  docker compose run --rm $container sh -c $command
}

alias ya = yazi
alias nv = nvim
alias zh = zathura
alias r = radian

def ssv [path: string] {
  cat $path | from csv --separator ';'
}
