if_inet_addr() {
    [[ $# -ne 1 ]] && echo "Usage: if_inet_addr IFNAME" && return 1
    ip address show $1 | sed -n 's/    inet \([^ /]\+\).*/\1/p'
}

docker_proxied_restart() {
    local host_ip=$(if_inet_addr enp0s3)
    systemctl --user set-environment HTTP_PROXY=http://${host_ip}:3128 HTTPS_PROXY=http://${host_ip}:3128
    systemctl --user daemon-reload
    systemctl --user restart docker
}

docker_proxied_build() {
    local host_ip=$(if_inet_addr enp0s3)
    docker build --build-arg=http_proxy="http://${host_ip}:3128" --build-arg=https_proxy="http://${host_ip}:3128" $*
}

docker_proxied_buildx() {
    local host_ip=$(if_inet_addr enp0s3)
    docker buildx build --build-arg=http_proxy="http://${host_ip}:3128" --build-arg=https_proxy="http://${host_ip}:3128" $*
}

jqdotted() {
    jq 'paths(scalars) as $p | $p + [getpath($p)] | join(".")' $1
}

which () {
    if [ "$(uname)" == "Darwin" ]; then
        /usr/bin/which $@
    else
        declare -f | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
    fi
}

path_prepend() {
    if [ -d "$1" ]; then
        PATH=${PATH//":$1:"/:} #delete all instances in the middle
        PATH=${PATH/%":$1"/} #delete any instance at the end
        PATH=${PATH/#"$1:"/} #delete any instance at the beginning
        PATH="$1${PATH:+":$PATH"}" #prepend $1 or if $PATH is empty set to $1
    fi
}

gg () {
    git grep "$@"
}

ggpy () {
    git grep "$@" -- '*.py'
}

ggi18n () {
    git grep "$@" -- '*/i18n/locales/*'
}

rgd () {
    rg --json -C 2 "$@" | delta
}
