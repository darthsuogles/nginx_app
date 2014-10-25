#!/bin/bash

ver=${1:-1.7.6}
nginx=$ver/build-tree/sbin/nginx

$nginx -s stop
$nginx -c $PWD/nginx.conf

url_prefix="http://localhost:8080"

function banner()
{    
    echo -e "\n------------------------------------"
    echo $1
}

banner "Test unicode names"
#curl "$url_prefix/hello_ngdk?person=%E7%AB%A0%E4%BA%A6%E6%98%A5"
unicode_names=("%E4%BA%8C%E6%B0%A7%E5%8C%96%E7%A2%B3" \
    "%E8%87%BA%E5%8C%97" "%E4%B9%99%E4%BA%8C%E9%85%B8%E9%85%90" \
    "%E0%B0%95%E0%B0%BE%E0%B0%B0%E0%B1%8D%E0%B0%AC%E0%B0%A8%E0%B1%8D_%E0%B0%A1%E0%B0%AF%E0%B0%BE%E0%B0%95%E0%B1%8D%E0%B0%B8%E0%B1%88%E0%B0%A1%E0%B1%8D" "%D0%A3%D0%B7%D1%8C%D0%BD%D1%8F%D1%81%D0%B5%D0%BD%D1%8C%D0%BD%D0%B5")
#for unom in $unicode_names; do
for (( i=0; i<${#unicode_names[@]}; ++i )); do
    curl "$url_prefix/hello_ngdk?person=${unicode_names[$i]}"
done

banner "Test array elemens"
curl "$url_prefix/list/Alice,Bob,Carla,Dorris"

banner "Test subrequests"
curl "$url_prefix/merge"
curl "$url_prefix/merge/moon,earth"
