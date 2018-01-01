require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.18'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.18.tar.gz'
  source_sha256 '728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d'

  binary_url ({
  })
  binary_sha256 ({
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

