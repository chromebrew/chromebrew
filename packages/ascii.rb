require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.18-1'
  compatibility 'all'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.18.tar.gz'
  source_sha256 '728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '63c6f3c239267c0b815e21f4dd697e2aff4eea42b7612f0e6ef2355bec4af25a',
     armv7l: '63c6f3c239267c0b815e21f4dd697e2aff4eea42b7612f0e6ef2355bec4af25a',
       i686: '842cdd491d6d8e7cfaafc2787cee021bbcf76bd70c70dd76397bff6391c9e3ef',
     x86_64: '4107a21b427fd0a090d73a89d06ace01d28d68ae84d56d3c3f159633304f1b22',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "gzip -9 ascii.1"
    system "install -Dm755 ascii #{CREW_DEST_PREFIX}/bin/ascii"
    system "install -Dm644 ascii.1.gz #{CREW_DEST_PREFIX}/man/man1/ascii.1.gz"
  end
end

