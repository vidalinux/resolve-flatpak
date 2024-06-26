#!/bin/bash

if [[ $1 = studio ]];
then
_downloadid='399deb23977e4b899a81734a070408d3'
_referid='7a1a0b5ffaf34f9588fd46683d40da75'
_pkgver=19.0b3
_archive_name=DaVinci_Resolve_Studio_${_pkgver}_Linux
_reqjson="{ \
    \"firstname\": \"Arch\", \
    \"lastname\": \"Linux\", \
    \"email\": \"someone@archlinux.org\", \
    \"phone\": \"202-555-0194\", \
    \"country\": \"us\", \
    \"state\": \"New York\", \
    \"city\": \"AUR\", \
    \"product\": \"DaVinci Resolve\" \
}"
else
_downloadid='3f82e78a15b14cb0a5a64a848bfce22f'
_referid='77ef91f67a9e411bbbe299e595b4cfcc'
_pkgver=19.0b3
_archive_name=DaVinci_Resolve_${_pkgver}_Linux
_reqjson="{ \
    \"firstname\": \"Arch\", \
    \"lastname\": \"Linux\", \
    \"email\": \"someone@archlinux.org\", \
    \"phone\": \"202-555-0194\", \
    \"country\": \"us\", \
    \"street\": \"Bowery 146\", \
    \"state\": \"New York\", \
    \"city\": \"AUR\", \
    \"product\": \"DaVinci Resolve\" \
}"
fi

_siteurl="https://www.blackmagicdesign.com/api/register/us/download/${_downloadid}"
_useragent="User-Agent: Mozilla/5.0 (X11; Linux ${CARCH}) \
                        AppleWebKit/537.36 (KHTML, like Gecko) \
                        Chrome/77.0.3865.75 \
                        Safari/537.36"

_reqjson="$(  printf '%s' "$_reqjson"   | sed 's/[[:space:]]\+/ /g')"
_useragent="$(printf '%s' "$_useragent" | sed 's/[[:space:]]\+/ /g')"
_useragent_escaped="${_useragent// /\\ }"
_srcurl="$(curl \
            -s \
            -H 'Host: www.blackmagicdesign.com' \
            -H 'Accept: application/json, text/plain, */*' \
            -H 'Origin: https://www.blackmagicdesign.com' \
            -H "$_useragent" \
            -H 'Content-Type: application/json;charset=UTF-8' \
            -H "Referer: https://www.blackmagicdesign.com/support/download/${_referid}/Linux" \
            -H 'Accept-Encoding: gzip, deflate, br' \
            -H 'Accept-Language: en-US,en;q=0.9' \
            -H 'Authority: www.blackmagicdesign.com' \
            -H 'Cookie: _ga=GA1.2.1849503966.1518103294; _gid=GA1.2.953840595.1518103294' \
            --data-ascii "$_reqjson" \
            --compressed \
            "$_siteurl")"
_archive=${_archive_name}.zip
wget $_srcurl -O $_archive
unzip $_archive
