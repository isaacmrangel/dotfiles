zi light z-shell/z-a-meta-plugins

zi light-mode for @annexes+ \
  @zsh-users+fast \
  skip'vivid tig hexyl' @console-tools

zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice as'program' from'gh-r' pick'zoxide' \
  atclone'ln -s completions/_zoxide -> _zoxide;
  cp man/man1/*.1 $ZI[MAN_DIR]/man1; ./zoxide init zsh --cmd x > init.zsh' \
  atpull'%atclone' src'init.zsh' nocompile'!'
zi light ajeetdsouza/zoxide

zinit as="command" lucid from="gh-r" for \
    id-as="usage" \
    atpull="%atclone" \
    jdx/usage
    #atload='eval "$(mise activate zsh)"' \

zinit as="command" lucid from="gh-r" for \
    id-as="mise" mv="mise* -> mise" \
    atclone="./mise* completion zsh > _mise" \
    atpull="%atclone" \
    atload='eval "$(mise activate zsh)"' \
    jdx/mise

zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"

zi light starship/starship
