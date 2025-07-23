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
    ver=
    nu=
    u=$(grep -1 "^name: ${p}$" packages.yaml | tail -1 | cut -d' ' -f2)
    if [[ -f ../packages/"$p.rb" ]]; then
      version=$(grep "^  @_ver" ../packages/"$p.rb" 2>/dev/null | cut -d= -f2 | xargs)
    else
      echo "- ../packages/$p.rb is missing."
      version=missing
    fi
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
      relu=
      gh_repo=
      relu=${u#*github.com/}
      relu=${relu%/releases}
      gh_repo=${relu%/tags}
      if [[ $u == *"/releases"* ]]; then
        ver=$(gh release ls --exclude-pre-releases --exclude-drafts -L 1 -R ${gh_repo} --json tagName -q '.[] | .tagName')
        if [[ $? == 0 ]]; then  
          [[ -z "$ver" ]] && echo "- https://github.com/${gh_repo} does not use releases."
        else
          echo "- https://github.com/${gh_repo} does not exist."
        fi
      fi
      if [[ $u == *"/tags"* ]] || [[ -z "$ver" ]]; then
        # This is empty if there is text in the git tag.
        ver=$(git -c 'versionsort.suffix=-' \
    ls-remote --exit-code --refs --sort='version:refname' --tags https://github.com/${gh_repo} '*.*.*' \
    | tail --lines=1 \
    | cut --delimiter='/' --fields=3)
      # This captures git tags with text if there is no exclusively
      # numeric version tag.
      [[ -z "$ver" ]] && ver=$(git ls-remote --tags https://github.com/${gh_repo} | cut -d'/' -f3 | grep -v "\^{}" | tail -n 1)
      fi
      nu=${u/releases/archive}
      [[ "$version" != "${ver#v}" ]] && echo "- [ ] $p$star | $nu/$ver.tar.gz | $version | ${ver#v}"
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
