#!/bin/zsh


# Setup SSH agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    echo "Initialising new SSH agent..."
    rm -fvr "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    #ps ${SSH_AGENT_PID} doesn't work under cywgin
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# System tools
export RANCHER_HOME=~/.rd

# Networking
#export http_proxy=http://proxy.bnz.co.nz:10568/
#export https_proxy=$http_proxy
#export HTTP_PROXY=$http_proxy
#export HTTPS_PROXY=$http_proxy
#export no_proxy='.nz.thenational.com,.bnz.digital,localhost,pac.bnz.co.nz'
#export NO_PROXY=$no_proxy
#export NODE_TLS_REJECT_UNAUTHORIZED=0

# BNZ Certs
#export SSL_CERT_FILE=/etc/ssl/java/cacerts.tony
#export MAVEN_OPTS="$MAVEN_OPTS -Djavax.net.ssl.trustStore=$SSL_CERT_FILE"
#export GRADLE_OPTS="$GRADLE_OPTS -Djavax.net.ssl.trustStore=$SSL_CERT_FILE"
#export CURL_CA_BUNDLE=/etc/pki/ca-trust/extracted/java/cacerts

# Development Tools
export SCRIPTS=~/Development/scripts
export MONGO_HOME=/opt/homebrew/opt/mongodb-community@4.4
export PYTHON_SYMLINKS=/opt/homebrew/opt/python@3.11/libexec/bin

# PATH
export PATH="$JAVA_HOME/bin:$SCRIPTS:$MONGO_HOME/bin:$PYTHON_SYMLINKS:$RANCHER_HOME/bin:$PATH"

export EDITOR='subl -w'

# Owner
export USER_NAME="newuser"

# VM Provisioning
export BEAKER_debug=yes
export BEAKER_destroy=no
export BEAKER_provision=no

# Red Hat Developer Subscription
export MINISHIFT_USERNAME=smithdefy
export MINISHIFT_PASSWORD=gc4oKJskerE6q2tQui4.

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }


# size of contents in dir and sort
function sizeAndSort() { du -kh -d 1 "$@" | sort -h }

function goToProject() {
    if [ -z $1 ]
    then
        cd ~/Development/projects
    else
        cd ~/Development/projects/$1
    fi
}

# Add
funtion addJavaHome() {
    export PATH="$PATH:$JAVA_HOME/bin"
}

#Java version
function j8() {
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export PATH="$JAVA_HOME/bin:$PATH"
}

function j11() {
    export JAVA_HOME=$(/usr/libexec/java_home -v 11)
    export PATH="$JAVA_HOME/bin:$PATH"
}

function j14() {
    export JAVA_HOME=$(/usr/libexec/java_home -v 14)
    export PATH="$JAVA_HOME/bin:$PATH"
}

function j21() {
    export JAVA_HOME=$(/usr/libexec/java_home -v 21)
    export PATH="$JAVA_HOME/bin:$PATH"
}

# default to java 21
j21
 

# Setup nvm
export NVM_DIR="$HOME/.nvm"
 [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias size=sizeAndSort
alias gdl=./gradlew
alias gdone='./gradlew clean test findbugsMain findbugsTest checkstyleMain checkstyleTest'
alias supergradle='./gradlew clean build  --refresh-dependencies'
alias supergradlewithinfo='./gradlew clean build --info --refresh-dependencies'
alias offlinegradle='./gradlew clean build --refresh-dependencies —-offline'
alias supergradlenotests='./gradlew clean build -x test --refresh-dependencies'
alias cleangradlecache='rm -fr ~/.gradle/caches ~/.gradle/wrapper'
alias oldbrew=/usr/local/bin/brew

# Use sublimetext for editing config files
alias zshconfig="subl ~/.zshrc"
alias envconfig="subl ~/.zsh-custom/env.sh"

# Directory aliases ***********************************************************
alias go-scripts='cd ~/Development/scripts'
alias go-projects=goToProject
alias go-data='cd /data'