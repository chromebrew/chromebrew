require 'package'

class Xmlto < Package
  description 'A tool for converting XML files to various formats.'
  homepage 'https://pagure.io/xmlto'
  version '0.0.28'
  compatibility 'all'
  source_url 'https://releases.pagure.org/xmlto/xmlto-0.0.28.tar.bz2'
  source_sha256 '1130df3a7957eb9f6f0d29e4aa1c75732a7dfb6d639be013859b5c7ec5421276'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlto-0.0.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmlto-0.0.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmlto-0.0.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlto-0.0.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f03c0544caa110a2af91afdf9b5a0b88b5e6ee2799cf4710cbe200b8bcf58a3',
     armv7l: '8f03c0544caa110a2af91afdf9b5a0b88b5e6ee2799cf4710cbe200b8bcf58a3',
       i686: 'd5f57827acde8c9977786a26790af5e517d95acd543ddb26efda8c7877d36bcf',
     x86_64: 'f4ce1d91e46a06d54877ff22ec0b0bb1da69c3e8ee5962536c722a0abe018fd9',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
