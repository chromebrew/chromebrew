#!/bin/bash

PWD_HOLD="${PWD}"

cd /tmp
if [[ -d /tmp/heroku-cli ]]; then
  cd heroku-cli
  git pull &>/dev/null
  cd ..
else
  git clone https://github.com/heroku/cli.git heroku-cli &>/dev/null
fi
cd heroku-cli
export HEROKU_V="$(git describe --abbrev=0 --tags)"
echo "${HEROKU_V}":
export SOURCE_URL="https://github.com/heroku/cli/archive/${HEROKU_V}.tar.gz"
export SOURCE_SHA256="$(wget -O- ${SOURCE_URL} 2>/dev/null | sha256sum | cut -d' ' -f1)"
echo "source_url '${SOURCE_URL}'"
echo "source_sha256 '${SOURCE_SHA256}'"
echo
echo "Package file located at ${PWD_HOLD}/heroku.rb"

cd "${PWD_HOLD}"

echo "require 'package'" > heroku.rb
echo >> heroku.rb
echo "class Heroku < Package" >> heroku.rb
echo "  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'" >> heroku.rb
echo "  homepage 'https://devcenter.heroku.com/articles/heroku-cli'" >> heroku.rb
echo "  version '${HEROKU_V}'" >> heroku.rb
echo "  source_url '${SOURCE_URL}'" >> heroku.rb
echo "  source_sha256 '${SOURCE_SHA256}'" >> heroku.rb
echo >> heroku.rb
echo "  binary_url ({" >> heroku.rb
echo "  })" >> heroku.rb
echo "  binary_sha256 ({" >> heroku.rb
echo "  })" >> heroku.rb
echo >> heroku.rb
echo "  depends_on 'yarn'" >> heroku.rb
echo >> heroku.rb
echo "  def self.build" >> heroku.rb
echo "    system 'yarn install'" >> heroku.rb
echo "  end" >> heroku.rb
echo >> heroku.rb
echo "  def self.install" >> heroku.rb
echo "    system \"mkdir -p #{CREW_DEST_PREFIX}/share/heroku\"" >> heroku.rb
echo "    system \"cp -r . #{CREW_DEST_PREFIX}/share/heroku\"" >> heroku.rb
echo "    system \"mkdir -p #{CREW_DEST_PREFIX}/bin\"" >> heroku.rb
echo "    system \"ln -s #{CREW_PREFIX}/share/heroku/bin/run #{CREW_DEST_PREFIX}/bin/heroku\"" >> heroku.rb
echo "  end" >> heroku.rb
echo "end" >> heroku.rb
