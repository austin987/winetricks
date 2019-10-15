#!/bin/sh

# build helloworld.exe for each version of C# that mono supports
# so that they can be used by winetricks-test/verify_*() in winetricks itself

# FIXME: check for mcs in $PATH

# FIXME: should we do 32/64bit versions?
for version in ISO-1 ISO-2 3 4 5 6 experimental; do
    # C# version to .Net version info can be found at:
    # https://www.guru99.com/c-sharp-dot-net-version-history.html

    case "$version" in
    ISO-1) dn_ver="1.0";;
    ISO-2) dn_ver="2.0";;
    3) dn_ver="3.0";;
    4) dn_ver="4.0";;
    5) dn_ver="4.5";;
    6) dn_ver="4.6";;

    # FIXME: this will change as mono supports newer versions, ideally should find
    # a more stable solution.
    experimental) dn_ver="4.7";;

    *) echo "unknown version"; exit 1;;
    esac
    
    # For arch: "The possible values are: anycpu, anycpu32bitpreferred, arm, x86, x64 or itanium. The default option is anycpu."
    for arch in x86 x64; do
        output="${dn_ver}-${arch}.exe"
        echo "Building ${output} for C# version ${version} / arch=${arch}"
        
        mcs "-langversion:${version}" "-out:${output}" "-platform:${arch}" helloworld.cs
    done
done
