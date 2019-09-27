require 'package'

class Config < Package
  description 'The GNU config.guess and config.sub scripts.'
  homepage 'https://savannah.gnu.org/projects/config'
  version '1912ca5'
  source_url 'http://git.savannah.gnu.org/cgit/config.git/snapshot/config-1912ca5.tar.gz'
  source_sha256 '3b9142de353991dada446a1bc55599838c0e066091ed63a184a9abce50f54724'

  def self.build
    system "cat << 'EOF' > config
#!/bin/bash
if ! test \$1; then
  echo 'Copy config.guess and config.sub to the destination directory.'
  echo 'Usage: config <destination directory>'
  echo 'Example: config . (copies config.guess and config.sub to the current directory)'
  exit 1
fi
if [ ! -d \$1 ]; then
  echo 'config destination directory is not valid.'
  exit 1
fi
cp #{CREW_PREFIX}/bin/config.[guess|sub] \$1
EOF"
  end

  def self.install
    system "install -Dm755 config #{CREW_DEST_PREFIX}/bin/config"
    system "install -Dm755 config.sub #{CREW_DEST_PREFIX}/bin/config.sub"
    system "install -Dm755 config.guess #{CREW_DEST_PREFIX}/bin/config.guess"
    system "install -Dm644 doc/config.sub.1 #{CREW_DEST_PREFIX}/share/man/man1/config.sub.1"
    system "install -Dm644 doc/config.guess.1 #{CREW_DEST_PREFIX}/share/man/man1/config.guess.1"
  end
end
