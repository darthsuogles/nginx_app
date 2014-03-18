#!/bin/bash

echo "array-var-nginx-module"
git submodule add \
    https://github.com/agentzh/array-var-nginx-module \
    ext-modules/array-var-nginx-module

echo "echo-nginx-module"
git submodule add \
    https://github.com/agentzh/echo-nginx-module \
    ext-modules/echo-nginx-module

echo "ngx_devel_kit"
git submodule add \
    https://github.com/simpl/ngx_devel_kit \
    ext-modules/ngx_devel_kit 

echo "set-misc-nginx-module" 
git submodule add \
    https://github.com/agentzh/set-misc-nginx-module/ \
    ext-modules/set-misc-nginx-module
