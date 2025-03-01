# last edited for Macbook Pro "Daisy" on 6-25-2016

#source ~/.bash_profile


#################################
#  Environment preferences
#################################
set -o emacs

# file permissions: rwxr-xr-x
umask	022

# set up environment for Arch
[ -f /etc/bash.bashrc ] && . /etc/bash.bashrc


###################################
# some useful variables
###################################

#------- Navigational Aids -------------
ul=/usr/local
ulb=/usr/local/bin
uls=/usr/local/src
ull=/usr/local/library
myblog=$HOME/public_html/daveblog/
thinkful=$HOME/bin/thinkful/projects

#export GOPATH=$HOME/bin/golang

#------ Skillcrush classes ------------
sc=$HOME/bin/ruby/skillcrush
sc104=$HOME/bin/ruby/skillcrush/skillcrush104
sc204=$HOME/bin/ruby/skillcrush/skillcrush204
scapp=$HOME/bin/ruby/skillcrush/skillcrush204/challenges/sinatra_ar/sinatra_mvc
scana=$HOME/bin/ruby/anagram/anagramApp
sc304=$HOME/bin/ruby/skillcrush/skillcrush304
scpin=$HOME/bin/ruby/skillcrush/skillcrush304/challenges/rails-pinning-app
scjs=$HOME/bin/js/skillcrush102
scwp=$HOME/public_html/accelerate

####################################
# some useful aliases
####################################

alias pyt='python3'
alias mp='/usr/bin/afplay'
#alias updatedb='sudo /usr/libexec/locate.updatedb'
alias h='fc -l'
#alias bh="less ~/.bash-help"
#alias ct='changetheme'
alias j=jobs
alias m="$PAGER"
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias g='egrep -i'
alias vimb='vim $HOME/.bashrc'
alias sb='source ~/.bashrc'
alias sbsh='source $HOME/.bashrc'
alias pg='ps aux|grep $1'
alias sd='echo $(date "+%A %b %d, %Y")'
alias st='echo $(date "+%T")'
alias hist="history"
alias dirs="dirs -v"
alias findip="ifconfig | grep 192 | cut -c21-33"

 
# # be paranoid
alias cp='cp -ip'
#alias mv='mv -i'
#alias rm='rm -i'

###################################
### Local variables
###################################

export OREILLY='djackson@cold.oreillyschool.com:workspace'
export GIT_CONFIG=$HOME/.gitconfig
export EDITOR=vim
export PATH=$PATH:$HOME/bin:/usr/local/games:/usr/local/bin:/usr/lib/java/bin:/usr/local/heroku/bin:$HOME/.cargo/bin
#export PGPPATH=/home/dsj/.pgp
export PAGER=less
export TMP=$HOME/tmp
export WHOIS_SERVER=whois.geektools.com
#export NNTPSERVER=news.east.earthlink.net
export TERM=xterm-256color
#export MYCOL="http://www.computoredge.com/sandiego/Editorial/idon'tdo.htm"
#export JAVA_PATH=/home/dsj/src/jre1.7_71

# For the paragraph reformatter called par
#export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'

export IRC_SERVERS_FILE="~/.servers"
export IRCNICK="dsj"
#export IRCNAME="David S. Jackson <dsj@dsj.net>"
export IRCNAME="David S. Jackson <deepbsd@yahoo.com>"
export IRCFINGER="Just exactly what more about me do you need to know???  Don't you know it's not polite to finger people without their consent?"

# # set prompt: ``username@hostname$ '' 
#PS1="`whoami`@`hostname | sed 's/\..*//'`"
#  This is default Mac bashprompt...
#PS1="\h:\W \u\$ "
#PS1="[\u@\h \W \$(parse_git_branch) ]$ "
#PS1="[\u@\h \W \$(parse_git_branch) ]$ "

PS1="[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W \[\033[00m\]\$(parse_git_branch) ]\$ "
PS2="> "
#case `id -u` in
# 	0) PS1="${PS1}# ";;
# 	*) PS1="${PS1}$ ";;
#esac

# search path for cd(1)
# CDPATH=.:$HOME


#################################
#   Functions
#################################

# ssh-agent
sshagent(){
    eval $(ssh-agent)
    ssh-add
}

# Use liquidctl to set colors on corsair h100i platinum
liq_led(){
    liquidctl list
    read -p "Which device number? " device
    liquidctl -d "$device" set led color fixed "rgb(11,45,138)"
}

sshadd(){
    eval $(ssh-agent)
    ssh-add 
}

# Compress and encrypt all files in a path
#  Something's wrong with this syntax: not working as expected.

zip_crypt(){
    tar czvpf - "$1" | gpg --symmetric -o "$2"
}

zip_decrypt(){
    gpg -d "$1" | tar xzvf - 

}

# create a blogpost for jekyll in ~/public_html/daveblog/
createpost()
{
  date=$(date --rfc-3339='seconds')
  day=$(date --rfc-3339='date')
  echo "Enter title: "
  read title
  echo "Categories? "
  read categories
  filename="${day}-${title}.markdown"
  directory="$HOME/public_html/daveblog/_posts/"

  cat > $directory/$filename <<End_of_Post
---
layout: post
title: ${title}
date: ${date}
categories: ${categories}
---
End_of_Post

  echo "Your post ${filename} has been created!"
}

# Find info on CPU archetecture on both
# Linux and OSX
findcpu()
{
  if (uname -s | grep 'Darwin' &>/dev/null); then
    CPU_INFO=`sysctl -n machdep.cpu.brand_string`
  else
    CPU_INFO=`cat /proc/cpuinfo | grep 'model name' | head -n1 | cut -c14-`
  fi
  echo $CPU_INFO
}

# show bash keyboard shortcuts
kbd_sc(){
 clear
cat << EOF | less
Moving the cursor:
  Ctrl + a   Go to the beginning of the line (Home)
  Ctrl + e   Go to the End of the line (End)
  Ctrl + p   Previous command (Up arrow)
  Ctrl + n   Next command (Down arrow)
   Alt + b   Back (left) one word
   Alt + f   Forward (right) one word
  Ctrl + f   Forward one character
  Ctrl + b   Backward one character
  Ctrl + xx  Toggle between the start of line and current cursor position
Editing:
 Ctrl + L   Clear the Screen, similar to the clear command

  Alt + Del Delete the Word before the cursor.
  Alt + d   Delete the Word after the cursor.
 Ctrl + d   Delete character under the cursor
 Ctrl + h   Delete character before the cursor (Backspace)

 Ctrl + w   Cut the Word before the cursor to the clipboard.
 Ctrl + k   Cut the Line after the cursor to the clipboard.
 Ctrl + u   Cut/delete the Line before the cursor to the clipboard.

  Alt + t   Swap current word with previous
 Ctrl + t   Swap the last two characters before the cursor (typo).
 Esc  + t   Swap the last two words before the cursor.

 ctrl + y   Paste the last thing to be cut (yank)
  Alt + u   UPPER capitalize every character from the cursor to the end of the current word.
  Alt + l   Lower the case of every character from the cursor to the end of the current word.
  Alt + c   Capitalize the character under the cursor and move to the end of the word.
  Alt + r   Cancel the changes and put back the line as it was in the history (revert).
 ctrl + _   Undo
 
 TAB        Tab completion for file/directory names
For example, to move to a directory 'sample1'; Type cd sam ; then press TAB and ENTER.
type just enough characters to uniquely identify the directory you wish to open.

Special keys: Tab, Backspace, Enter, Esc Text Terminals send characters (bytes), not key
strokes.  Special keys such as Tab, Backspace, Enter and Esc are encoded as control
characters.  Control characters are not printable, they display in the terminal as ^ and are
intended to have an effect on applications.

Ctrl+I = Tab
Ctrl+J = Newline
Ctrl+M = Enter
Ctrl+[ = Escape

Many terminals will also send control characters for keys in the digit row:
Ctrl+2 : ^@
Ctrl+3 : ^[ Escape
Ctrl+4 : ^\
Ctrl+5 : ^]
Ctrl+6 : ^^
Ctrl+7 : ^_ Undo
Ctrl+8 : ^? Backward-delete-char

Ctrl+v tells the terminal to not interpret the following character, so Ctrl+v Ctrl-I will
display a tab character, similarly Ctrl+v ENTER will display the escape sequence for the Enter
key: 

History:
  Ctrl + r   Recall the last command including the specified character(s).
             searches the command history as you type.
             Equivalent to : vim ~/.bash_history. 
  Ctrl + p   Previous command in history (i.e. walk back through the command history).
  Ctrl + n   Next command in history (i.e. walk forward through the command history).

  Ctrl + s   Go back to the next most recent command.
             (beware to not execute it from a terminal because this will also launch its XOFF).
  Ctrl + o   Execute the command found via Ctrl+r or Ctrl+s
  Ctrl + g   Escape from history searching mode
        !!   Repeat last command
       !n    Repeat from the last command: args n e.g. !:2 for the second argumant.
       !n:m  Repeat from the last command: args from n to m. e.g. !:2-3 for the second and third.
       !n:$  Repeat from the last command: args n to the last argument.
       !n:p  Print last command starting with n
     !string Print the last command beginning with string.
       !:q   Quote the last command with proper Bash escaping applied.
              Tip: enter a line of Bash starting with a # comment, then run !:q on the next line to escape it.
        !$   Last argument of previous command.
   ALT + .   Last argument of previous command.
        !*   All arguments of previous command.
^abc^def   Run previous command, replacing abc with def
Process control:
 Ctrl + C   Interrupt/Kill whatever you are running (SIGINT).
 Ctrl + l   Clear the screen.
 Ctrl + s   Stop output to the screen (for long running verbose commands).
            Then use PgUp/PgDn for navigation.
 Ctrl + q   Allow output to the screen (if previously stopped using command above).
 Ctrl + D   Send an EOF marker, unless disabled by an option, this will close the current shell (EXIT).
 Ctrl + Z   Send the signal SIGTSTP to the current task, which suspends it.
            To return to it later enter fg 'process name' (foreground).
Emacs mode vs Vi Mode
All the above assume that bash is running in the default Emacs setting, if you prefer this can be switched to Vi shortcuts instead.

Set Vi Mode in bash:

$ set -o vi 
Set Emacs Mode in bash:
$ set -o emacs 
EOF
}

qtile_sc(){
    clear
cat << EOF | less
BASIC QTILE COMMANDS (DAVE'S)
==============================

##        Misc commands
mod + r                  spawn a command
mod + q                  kill a window
mod + Enter              launch a terminal
mod + r                  spawn a command cli
mod + ctrl + r           restart qtile

mod + Tab                cycle layout
mod + x                  exit qtile
mod + n                  normalize layout

mod + s                  focus to monitor 1
mod + shift + s          focus to monitor 2
mod + shift + f          flip layout (monad layouts only)

mod1 + ctrl + Left       previous workspace
mod1 + ctrl + Right      next workspace

##         move window focus
mod + Space              move focus to next window
mod + h                  move focus to left window
mod + l                  move focus to right window
mod + j                  move focus to window below
mod + k                  move focus to window above

##         move window to group num
mod + Shift + num        move window to group num

##         move focus to group num
mod + num                move focus to group num
mod + ctrl + Left        move focus to previous group
mod + ctrl + Right       move focus to next group

##         grow window (arrow keys also work)
mod + ctrl + h           grow window to left
mod + ctrl + l           grow window to right
mod + ctrl + j           grow window to down
mod + ctrl + k           grow window to up

##         move window inside current group
mod + Shift + h          move window to left in stack
mod + Shift + l          move window to right in stack
mod + Shift + j          move window to down in stack
mod + Shift + k          move window to up in stack
EOF
}

calc () { 
    bc <<< "$@"; 
}

# Create playlist for mpg123 on the fly
#  *** this doesn't work on OSX yet ***
mlist()
{
  dir=$HOME/Music/iTunes/iTunes\ Media/Music/
  list="$dir/*/*.m??"
  
  for i in $list; do
  afplay `echo $i|sed -e 's/ /\ /g'`
  done
}

# window manager choice function removed 6-8-2016

# enable git branch tracking
parse_git_branch(){
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# history function
his()
{
history ${1:-22}
}

histsort()
{
echo "Do you want the full argument or just the base command?"
read answer

if echo $answer | grep -i y ; then
  history 1000 | tr -s " " | cut -d " " -f3- | sort | uniq -c | sort -r 
else
  history 1000 | cut -d' ' -f5 | sort | uniq -c | sort -r 
fi
}

sendkey(){
    user=$(whoami)
    remote_host=$1
    if [[ -x $(which ssh-copy-id) ]]; then 
        ssh-copy-id "$user"@"$remote_host"
    else
        cat ~/.ssh/id_rsa.pub | ssh "$user"@"$remote_host" 'tee -a .ssh/authorized_keys'
    fi
}

checkhosts(){
    myhosts=()
    if [[ -f ~/dotfiles/.my_machines.txt ]]; then
        myhosts=( $(cat ~/dotfiles/.my_machines.txt | sed '/^$/d' | sed '/#.*$/d' | cut -d' ' -f1 | tr '[:upper:]' '[:lower:]') )
        for machine in ${myhosts[@]}; do
            ( ping -c2 $machine &>/dev/null && echo "UP: $machine"  ) || echo "DOWN: $machine"
        done
    else
        echo "Sorry, no .my_machines.txt file"
        return 1
    fi
}

# List contents of a zip file
#cz(){
#
#    if $( test /usr/bin/unzip ); then
#        unzip -l $*
#    else 
#        echo "unzip not installed..."
#    fi
#}


# List contents of a tarball
ctgz()
{
for file in $* ; do
gzip -dc ${file} | tar tf -
done
}

# Create a tar.gz tarball from name $1 and $2
tarc()
{
tar czvf $1.tar.gz $2
}

# Move a directory across a filesystem using tar
tarm()
{
source=$1
dest=$2
cd $source
tar cf - . | (cd $dest; tar xvf -)
}


# Here are some bashprompt themes

bp()
{
clear; echo -e "\n                 Bash Prompt Themes: \n blue, combo, cyan, elite, elite2, fire, green, \nmagenta, red, redhat, macbook, suse, white, yellow, friendly, spiffy  \n\n" 
read pchoice

case "$pchoice" in 
  blue) PS1="\[\033[34;44;1m\]\333\262\261\260\[\033[37;44;1m\]\u@\h\[\033[0m\]\[\033[34;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P) \n\[\033[34;40;1m\]\w \[\033[0m\]\$ "
       PS2="\[\033[34;40m\]\333\262\261\260\[\033[0m\]>"  
  ;;
  combo) PS1="\[\033[01;34;01m\]\333\262\261\260\[\033[01;37;44m\]\u@\h\[\033[00;34;40m\]\260\261\262\333\[\033[00;34;40m\]\333\262\261\260\[\033[01;37;40m\] \d \$(date +%I:%M:%S%P)\n\[\033[01;33;40m\]$PWD>\[\033[00m\] " 
         PS2="\[\033[01;34;01m\]\333\262\261\260\[\033[00;34;40m\]\260\261\262\333\[\033[00;34;40m\]\333\262\261\260\[\033[01;01;34m\]>\[\033[00m\] "
  ;;
  cyan) PS1="\[\033[36;46;1m\]\333\262\261\260\[\033[37;46;1m\]\u@\h\[\033[0m\033[36;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P) \n\[\033[36;40;1m\]\w/\[\033[0m\] " 
        PS2="\[\033[36;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  elite) PS1="\[\033[31m\]\332\304\[\033[34m\](\[\033[31m\]\u\[\033[34m\]@\[\033[31m\]\h\[\033[34m\])\[\033[31m\]-\[\033[34m\](\[\033[31m\]\$(date +%I:%M%P)\[\033[34m\]-:-\[\033[31m\]\$(date +%m)\[\033[34m\033[31m\]/\$(date +%d)\[\033[34m\])\[\033[31m\]\304-\[\033[34m]\\371\[\033[31m\]-\371\371\[\033[34m\]\372\n\[\033[31m\]\300\304\[\033[34m\](\[\033[31m\]\W\[\033[34m\])\[\033[31m\]\304\371\[\033[34m\]\372\[\033[00m\]" 

         PS2="> "
  ;;
  elite2) local GRAD1=`tty|cut -d/ -f3`
          local COLOR1="\[\033[0;36m\]"
          local COLOR2="\[\033[1;36m\]"
          local COLOR3="\[\033[1;30m\]"
          local COLOR4="\[\033[0m\]"
          PS1="$COLOR3�$COLOR1�$COLOR2($COLOR1\u$COLOR3@$COLOR1\h$COLOR2)$COLOR1�$COLOR2($COLOR1\#$COLOR3/$COLOR1$GRAD1$COLOR2)$COLOR1�$COLOR2($COLOR1\$(date +%I:%M%P)$COLOR3:$COLOR1\$(date +%m/%d/%y)$COLOR2)$COLOR1�$COLOR3-$COLOR4\n$COLOR3�$COLOR1�$COLOR2($COLOR1\$$COLOR3:$COLOR1\w$COLOR2)$COLOR1�$COLOR3-$COLOR4 "
          PS2="$COLOR2�$COLOR1�$COLOR3-$COLOR4 " 
  ;;
  fire)  local GRAD1='\[\333\262\261\260\]'
         local GRAD2='\[\260\261\262\333\]'
         local COLOR1='\[\033[01;33;43m\]'
         local COLOR2='\[\033[01;37;43m\]'
         local COLOR3='\[\033[00;31;43m\]'
         local COLOR4='\[\033[00;31;40m\]'
         local COLOR5='\[\033[01;33;40m\]'
         local COLOR6='\[\033[01;37;40m\]'
         local GRAD0='\[\033[00m\]'

         PS1=$COLOR1$GRAD1$COLOR2'\u@\h'$COLOR3$GRAD2$COLOR4$GRAD1\ $COLOR6' \d \$(date +%I:%M:%S%P) '$NONE'\n'$COLOR5'\w/'$GRAD0' ' 
         PS2=$COLOR1$GRAD1$COLOR3$GRAD2$COLOR4$GRAD1$COLOR5'>'$GRAD0' '
  ;;
  green)  PS1="\[\033[32;42;1m\]\333\262\261\260\[\033[37;42;1m\]\u@\h\[\033[0m\033[32;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P) \n\[\033[32;40;1m\]\w/\[\033[0m\] " 
          PS2="\[\033[32;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  magenta) PS1="\[\033[35;45;1m\]\333\262\261\260\[\033[37;45;1m\]\u@\h\[\033[0m\033[35;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P) \n\[\033[35;40;1m\]\w/\[\033[0m\] " 
           PS2="\[\033[35;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  red) PS1="\[\033[31;41;1m\]\333\262\261\260\[\033[37;41;1m\]\u@\h\[\033[0m\033[31;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P)\n\[\033[31;40;1m\]\w/\[\033[0m\] " 
       PS2="\[\033[31;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  redhat)  PS1="[\u@\h \W]\\$ "
           PS2="> "
  ;;
  macbook) PS1="\h:\W \u\$ "
           PS2="> "
  ;;
  suse)   PS1="\u@\h:\w/ > "
          PS2="> "
  ;;
  white)  PS1="\[\033[37;47;1m\]\333\262\261\260\[\033[37;47;1m\]\u@\h\[\033[0m\033[37;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P) \n\[\033[37;40;1m\]\w/\[\033[0m\] " 
          PS2="\[\033[37;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  yellow) PS1="\[\033[33;43;1m\]\333\262\261\260\[\033[37;43;1m\]\u@\h\[\033[0m\033[33;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P)\n\[\033[33;40;1m\]\w/\[\033[0m\] " 
          PS2="\[\033[33;40m\]\333\262\261\260\[\033[0m\]>"
  ;;
  friendly)  PS1="Time: \d \t  Hi \u@\h You are in -> \w \n Cmd: \# His: \!]\$ "
  ;;
  spiffy)  PS1="\[\033[1;35m\] \$(sd) \[\033[1;31m\] \u@\h \[\033[1;36m\] c: \#  h: \!  \n\[\033[1;32m\] \w ]\$ \[\033[0m\] " 
  ;;
  *)  echo -e "\nPlease type your answer exactly as it appears in the menu above.  \n\n"
  ;;
esac

export PS1 PS2

}

####################################################
###    Powerline
####################################################
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1


if  (grep -i 'debian' /etc/os-release > /dev/null ); then
    . /usr/share/powerline/bindings/bash/powerline.sh
else
    .  /usr/lib/python3.13/site-packages/powerline/bindings/bash/powerline.sh
fi

# don't need this line with else clause
#. /usr/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh




####################################################
###    Miscelanious  Stuff for other programs
####################################################

# fire off compton compositor for transparency in i3wm only...
#if ! pgrep -x "compton" > /dev/null
#then
#compton &
#fi

# put a wallpaper on the root window if it doesn\'t exist already
#feh --bg-scale ~/wallpaper/SanFranGGBridge4K.jpg


# added by travis gem
[ -f /home/dsj/.travis/travis.sh ] && source /home/dsj/.travis/travis.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# RVM is the Ruby Version Manager
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"

# source the fzf startup configs.  Also use extended regex matching configs
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPS="--extended"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
