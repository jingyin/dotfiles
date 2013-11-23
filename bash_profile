source $HOME/.bashrc

if [[ $OSTYPE == darwin* ]]; then
    export PATH=/usr/local/Cellar/smlnj/110.74/libexec/bin:$PATH
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/Cellar/smlnj/110.74/libexec/bin:$PATH
    export PATH=/Applications/Racket\ v5.3.6/bin:$PATH
    export GOROOT=/usr/local/go
    alias emacs="/usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs -nw"

    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
fi
