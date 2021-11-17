# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/liam/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="3den"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# user alias
alias cl="clear"
alias sf="screenfetch"

# set git proxy
export HOST_IP=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
git config --global http.https://github.com.proxy "socks5://${HOST_IP}:33333"
git config --global https.https://github.com.proxy "socks5://${HOST_IP}:33333"
# cancel git proxy
alias gitnp="git config --global --unset http.proxy && git config --global --unset https.proxy"

# set xlaunch
export DISPLAY=$HOST_IP:0.0
export LIBGL_ALWAYS_INDIRECT=1

# set synopsys
export SYNOPSYS=/opt/synopsys
# scl
export SCL_HOME=$SYNOPSYS/scl/2018.06
# syn
export DC_HOME=$SYNOPSYS/syn/O-2018.06-SP1
# icc2
export ICC2_HOME=$SYNOPSYS/icc2/O-2018.06-SP1
# pts
export PT_HOME=$SYNOPSYS/pts/O-2018.06-SP1
# pwr
export PWR_HOME=$SYNOPSYS/pwr/O-2018.06-SP3
# lc
export LC_HOME=$SYNOPSYS/lc/O-2018.06-SP1
export SYNOPSYS_LC_ROOT=$SYNOPSYS/lc/O-2018.06-SP1
# vcs
export VCS_HOME=$SYNOPSYS/vcs/O-2018.09-SP2
# verdi
export VERDI_HOME=$SYNOPSYS/verdi/Verdi_O-2018.09-SP2

# add synopsys tools to PATH
# scl
export PATH=$PATH:$SCL_HOME/linux64/bin
# syn
export PATH=$PATH:$DC_HOME/bin
# icc2
export PATH=$PATH:$ICC2_HOME/bin
# pts
export PATH=$PATH:$PT_HOME/bin
# pwr
export PATH=$PATH:$PWR_HOME/bin
# lc
export PATH=$PATH:$LC_HOME/bin
# vcs
export PATH=$PATH:$VCS_HOME/bin
# dve
export PATH=$PATH:$VCS_HOME/gui/dve/bin
# verdi
export PATH=$PATH:$VERDI_HOME/bin

# license variables
export SNPSLMD_LICENSE_FILE=27000@localhost
export LM_LICENSE_FILE=$SCL_HOME/admin/license/Synopsys.dat

# alias for hacking synopsys
alias hack="lmgrd -c $LM_LICENSE_FILE -l ~/hack_synopsys.log" 

# set static mac
static_mac=7e:ca:66:9d:b3:68
current_mac=$(ip link show bond0 | awk '/ether/ {print $2}')
if [[ $current_mac !=  $static_mac ]]; then
    sudo ip link set dev bond0 address $static_mac
    sleep 2
    lmgrd -c $LM_LICENSE_FILE -l ~/hack_synopsys.log 
fi
