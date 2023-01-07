#!/bin/bash
if [ ! -f packages.yaml ]; then
  echo "packages.yaml not found."
  exit 1
fi
if test "$1"; then
  valid=
  opt="core high medium low"
  for o in $opt; do
    [ "$1" == "$o" ] && valid=1
  done
  if ! test "$valid"; then
    echo "Usage: $0 [activity] [offset] [lines]"
    echo "activity: core|high|medium|low"
    echo "offset: # of lines to skip"
    echo "lines: # of lines to check"
    exit 1
  fi
  if [[ "$1" == "core" ]]; then
    rm -f /tmp/urls.txt
    cat core_packages.txt > /tmp/names.txt
    ps=$(< /tmp/names.txt)
    ps=$(echo "$ps" | xargs)
    for p in $ps; do
      grep -1 "^name: ${p}$" packages.yaml | tail -1 | cut -d' ' -f2  >> /tmp/urls.txt
    done
  else
    grep -2 "^activity: $1" packages.yaml > /tmp/activity.txt
    grep ^name: /tmp/activity.txt | cut -d' ' -f2  > /tmp/names.txt
    grep ^url: /tmp/activity.txt | cut -d' ' -f2 > /tmp/urls.txt
    rm -f /tmp/activity.txt
  fi
else
  grep ^name: packages.yaml | cut -d' ' -f2 > /tmp/names.txt
  grep ^url: packages.yaml | cut -d' ' -f2 > /tmp/urls.txt
fi
if test "$2"; then
  lines=$(wc -l /tmp/urls.txt | cut -d' ' -f1)
  offset="$2"
  urls=$((lines-offset))
  if test "$3"; then
    count=$3
    tail "-$urls" /tmp/names.txt | head "-$count" > /tmp/new_names.txt
    tail "-$urls" /tmp/urls.txt | head "-$count" > /tmp/new_urls.txt
  else
    tail "-$urls" /tmp/names.txt > /tmp/new_names.txt
    tail "-$urls" /tmp/urls.txt > /tmp/new_urls.txt
  fi
  mv /tmp/new_names.txt /tmp/names.txt
  mv /tmp/new_urls.txt /tmp/urls.txt
fi
c=0
ps=$(< /tmp/names.txt)
ps=$(echo "$ps" | xargs)
for p in $ps; do
  a=$(grep -2 "^name: ${p}$" packages.yaml | tail -1 | cut -d' ' -f2)
  if [ "$a" != "none" ]; then
    star=
    repo=
    u=$(grep -1 "^name: ${p}$" packages.yaml | tail -1 | cut -d' ' -f2)
    version=$(grep "^  @_ver" ../packages/"$p.rb" 2>/dev/null | cut -d= -f2 | xargs)
    [ -z "$version" ] && version=$(grep "^  version" ../packages/"$p.rb" | cut -d"'" -f2)
    cp=$(grep "^${p}$" core_packages.txt)
    test "$cp" && star="*"
    [[ "$u" == *"gnu.org"* ]] && repo="gnu"
    [[ "$u" == *"github.com"* && $u == *"/releases"* ]] && repo="github"
    [[ "$u" == *"savannah.gnu.org"* && $u == *"/releases"* ]] && repo="savannah"
    case "$repo" in
    gnu)
      content=$(curl -Ls "$u")
      content=${content/[ds|latest].tar//}
      d=${content##*\.tar\.[g|l|x]z\">}
      rel=$(echo "$d" | cut -d'<' -f1 | cut -d'-' -f2 | xargs)
      ver=${rel%.tar*}
      nu="$u/$p-$rel"
      [[ "$version" != "$ver" ]] && echo "- [ ] $p$star | $nu | $version | $ver"
      ;;
    github)
      relu=${u#*com}/tag/
      content=$(curl -Ls "$u" | grep "href=\"$relu")
      d=${content#*/releases/tag/}
      rel=$(echo "$d" | cut -d'"' -f1)
      rel=$(echo "$rel" | cut -d' ' -f1)
      ver=${rel%.zip*}
      nu=${u/releases/archive}
      [[ "$version" != "$ver" ]] && echo "- [ ] $p$star | $nu/$ver.tar.gz | $version | $ver"
      ;;
    savannah)
      content=$(curl -Ls "$u")
      d=${content##*\.tar\.[g|l|x]z\">}
      rel=$(echo "$d" | cut -d'<' -f1 | cut -d'-' -f2 | xargs | cut -d' ' -f1)
      rel=${rel% *}
      ver=${rel%.tar*}
      nu="$u/$p-$rel"
      [[ "$version" != "$ver" ]] && echo "- [ ] $p$star | $nu | $version | $ver"
      ;;
    *)
      echo "- [ ] $p$star | $u | $version | not checked"
    esac
    c=$((c+1))
  fi
done
echo "Total packages: $c"
#most /tmp/urls.txt
#if ! test $(command -v elinks 2> /dev/null); then
#  crew install elinks
#fi
#for u in $(cat /tmp/urls.txt); do elinks $u; done
#rm -f /tmp/names.txt
#rm -f /tmp/urls.txt
