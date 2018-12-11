#!/bin/bash
declare -a hosts=(
    # "$USER"@10.211.55.28
    # "$USER"@213.131.1.5
    # "$USER"@213.131.1.13
    # "$USER"@213.131.1.41
    # "$USER"@213.131.1.43
    # "$USER"@213.131.1.44
    "$USER"@mysql.sinp.msu.ru
    # "$USER"@213.131.1.111
    "$USER"@andra.sinp.msu.ru
    "$USER"@beowulf.sinp.msu.ru
    "$USER"@dec1.sinp.msu.ru
    "$USER"@dev01.sinp.msu.ru
    "$USER"@downloader.sinp.msu.ru
    # "$USER"@ftp.sinp.msu.ru
    # "$USER"@helios.sinp.msu.ru
    # "$USER"@jai.sinp.msu.ru
    # "$USER"@jupiter.sinp.msu.ru
    "$USER"@mars.sinp.msu.ru
    "$USER"@tarn.sinp.msu.ru
    root@helios.sinp.msu.ru
    root@mars.sinp.msu.ru
    # "$USER"@tarsus.sinp.msu.ru
    mimisbrunnr
)
for host in "${hosts[@]}"; do
    echo "Deploying to $host"
    # ssh-copy-id "$host"
    ssh -t "$host" rm .hushlogin
    scp "$(pwd)"/.* "$host":~
done
