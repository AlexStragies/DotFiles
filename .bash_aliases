#╔════════════════════════════════════════════════════════════════════════════╗
#║                                                                            ║
#║ .bash_aliases  -- Default file/location for useful aliases and functions.  ║
#║                                                                            ║
#║ This file is automatically sourced by a standard debian bash install.      ║
#║ It can also be run by itself.                                              ║
#║                                                                            ║
#║ This file also runs a .bashrc.local, if it finds one.                      ║
#║ Blablabla ...                                                              ║
#║                                                                            ║
#╚════════════════════════════════════════════════════════════════════════════╝


#┌────────────────────┐
#│ Utility functions: │
#└────────────────────┘
alias isEmpty="test -z"
Error(){ echo -e "[EE] $@"; }
Usage(){ echo -e "[Usage] : $@"; }
repeat(){ for (( c=1 ; c<=$1 ; c++  )); do echo -n "$2" ; done }

# cd aliases
alias cd-='cd -'
alias c-='cd -'
alias c='cd'
alias cd..='cd ..'
alias c..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
for i in {2..9}; do eval "alias ..$i='cd ..$(repeat $(($i-1)) '/..')'" ; done

# ls and dir aliases:
# "ls" is already aliased to "ls --color", and will evaluate recursively
alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -CF'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# grep aliases and shortcuts:
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias g='grep'

# sed aliases and shortcuts:
alias s='sed'
alias se='sed -e'
alias cutHeader='se "1d"'
#snip(){ sed -e "s/$1//g"; }
snip(){
  isEmpty $1 &&{ Error 'Parameter required'; Usage "snip [regexp]"; return;};
  se "s/$1//g"; }
repl(){ sed -e "s/$1/g"; }

# Programs and Processes:
alias ptree="pstree -hanpA | less -RS"
alias psrch="apt-cache search"
alias pshow="apt-cache show"

# Misc Shortcuts:
alias m=man
alias nsf="netstat -tnulp | grep"
alias o="less -RS"
alias p=ping
-h(){ $1 --help 2>&1 | o; }
alias dirSizes='du -hsx * | sort -rh'
findFile() { find "${2:-.}" -type f -iname "*$1*" 2>/dev/null; }
psgrep(){ ps aux | grep -E "[${1:0:1}]${1:1}|^USER"; }

alias tmx="exec ~/bin/mtx.sh -d"
alias ntmx="exec ~/bin/mtx.sh -d -n"
alias filesh="nautilus ~/scp/file/home/$USER"
alias filesu="nautilus ~/scp/file/media/Data"
alias kpp="kpcli --kdb ~/scp/file/home/$USER/KeePass/Database.kdb"

alias ec="emacsclient -n -q"
alias edt="emacsclient -t"
alias edg="ec -c"
alias esh="emacsclient -t -e '(eshell)'"

# Some Root-only Aliases:
[[ $UID == '0' ]] && {
  alias pinst="apt-get install"
}

which virsh > /dev/null && {
  alias vs=virsh
  alias vmList='virsh list'
  alias vmListAll='virsh list --all'
  alias vmDiskList='virsh domblkinfo'
}

printtsv(){
  isEmpty $1 &&{ Error 'Parameter required'; Usage "printtsv file"; return;};
  q -tb "SELECT * FROM $1" \
      | lp -o landscape \
           -o fit-to-page \
           -o media=A4 ;
}

vim () {
    local params=();
    while [[ ! -z $1 ]]; do
        if [[ "$1" =~ ^[a-z0-9-]*:/.*$ ]]; then
            params=("scp://${1/:\//\/\//}" "${params[@]}");
        else
            params+=("$1");
        fi;
        shift;
    done;
    echo vim ${params[@]};
    /usr/bin/vim ${params[@]};
}

box() {
echo -e "╔$(repeat 60 ═)╗
║$(repeat 60 ' ')║
╠$(repeat 60 ═)╣
║$(repeat 60 ' ')║
╟$(repeat 60 ─)╢
╚$(repeat 60 ═)╝";

}

head_tail() {
    head -n "$@";
    tail -n "$@";
}

toTable() {
  column -t | awk 'BEGIN{a="'$(tput smul)'";b="'$(tput sgr0)'"} {print a $0 b}'
}

# If there is a .bashrc.local, then execute it:
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

#run -b 'tmux setenv -g U_FullName "$(getent passwd `whoami` | cut -d : -f 5 | cut -d , -f 1 )"'
#run -b 'U_FullName="$(getent passwd `whoami` | cut -d : -f 5 | cut -d , -f 1 )";''
#╔════════════════════════════════════════════════════════════╗
#║ asdifaskdfasd?/äasdklöf                                       ║
#╠════════════════════════════════════════════════════════════╣
#║                                                            ║
#╠════════════════════════════════════════════════════════════╣
#║                                                            ║
#╟────────────────────────────────────────────────────────────╢
#╚════════════════════════════════════════════════════════════╝
