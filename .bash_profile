export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:~/bin/:$PATH
export EDITOR='subl -w'

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


#stashes
count_git_stash() {
	git stash list 2> /dev/null | wc -l | sed 's/^ *//g'
}
render_git_stash() {
	if [[ $(count_git_stash) != "0" ]]; then 
		echo " 👨  $(count_git_stash)"
	fi
}		

# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)$(render_git_stash)]/"
}
export PS1="sarah: \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Git branch dirty
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
 
export CODE_DIR=$HOME/Documents/_SRO/code
export DOTFILES_DIR=$CODE_DIR/dotfiles

source $DOTFILES_DIR/.aliases