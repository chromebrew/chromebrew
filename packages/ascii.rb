require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.18'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.18.tar.gz'
  source_sha256 '728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8afd3dd8d8bbb56f039bd51dd2e0a65fdd23449b3858fb328fd0d2cbb75382b9',
     armv7l: '8afd3dd8d8bbb56f039bd51dd2e0a65fdd23449b3858fb328fd0d2cbb75382b9',
       i686: '9c5f93b333c1b40e558c76ab082bf5cfd7541a6f36f3c4561250e7dc2db45d26',
     x86_64: 'cfce0c56efacea56a77d481d6f5001645972fa4780a2a8dea921f9435dffc466',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp ascii #{CREW_DEST_PREFIX}/bin"
    system "cp ascii.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end

