require 'package'

class Hashpipe < Package
  description 'Hash in a pipe'
  homepage 'https://git.zx2c4.com/hashpipe/about/#hashpipe'
  version '1.0'
  compatibility 'all'
  source_url 'https://git.zx2c4.com/hashpipe/snapshot/hashpipe-dc11b6262f4717e61e55760cb2bd637ff1c0f6a9.tar.xz'
  source_sha256 '6b3931d7c46332be2a6c07f94f91924065ba7988edd2e8a471123c77d3c614f6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hashpipe-1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hashpipe-1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hashpipe-1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hashpipe-1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6285f0a271d517f5a945626d9d84378546cd463d3ef2d6bcb6cdc189b8beed25',
     armv7l: '6285f0a271d517f5a945626d9d84378546cd463d3ef2d6bcb6cdc189b8beed25',
       i686: 'd03e7e5b7990c41bd8f25e17469db59bf3f1575a00ffb10f5fb441217ddabee9',
     x86_64: 'fa770efb0a691063e7b2f581abde45d9bacf0822ff9643136d9bf99dd5d42f6b'
  })

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make PREFIX=#{CREW_PREFIX} install"
  end
end
