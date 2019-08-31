#!/usr/bin/env bash

######################################################
#
#  Each time I clone my dotfiles, I get empty directories
#  in .vim/bundle.  I get tired of having to re-clone them
#  each time I set up a new machine, so this script helps
#  save me the leg work!
#
#  This script will add vim plugin repos to your 
#  ~/.vim/bundle directory



# The plugins I use ...
myplugins=(
    'git@github.com:tpope/vim-surround.git'
    'git@github.com:tpope/vim-fugitive.git'
    'git@github.com:vim-syntastic/syntastic.git'
    'git@github.com:ervandew/supertab.git'
    'git@github.com:Yggdroot/indentLine.git'
    'git@github.com:mattn/emmet-vim.git'
    'git@github.com:jiangmiao/auto-pairs.git'
    )

# target dir
target_dir=$HOME/.vim/bundle

# return 0 if dir exists and is empty
check_dir(){
   name=$1
   dir=$(basename ${name%.git})
   [ -d $dir ] && [ -z "$(ls -A $dir)" ] && return 0
   return 1
}


# if the directory existx and is empty, 
# then clone the repo
clone_repo(){
    name=$1
    git clone "$target_dir/$name"
}

clone_all(){
    for name in ${myplugins[@]}; do
        dir=$(basename ${name%.git})
        if $(check_dir $dir); then 
            clone_repo $name
        fi
    done
}

# Do the deed
clone_all


