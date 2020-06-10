require 'package'

class Lsscsi < Package
  description 'The lsscsi command lists information about SCSI devices in Linux.'
  homepage 'http://sg.danny.cz/scsi/lsscsi.html'
  version '0.28'
  compatibility 'all'
  source_url 'https://github.com/hreinecke/lsscsi/archive/v0.28.tar.gz'
  source_sha256 'eec0c2c10b30d58aa8d7c7703ccbca92215939632ce3fea599f280f8390553e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lsscsi-0.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lsscsi-0.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lsscsi-0.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lsscsi-0.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38b24d217de71e9b295edccaad466aa41a25803b87725a26aeff1aa17e5a4bc5',
     armv7l: '38b24d217de71e9b295edccaad466aa41a25803b87725a26aeff1aa17e5a4bc5',
       i686: '44b1427c916692e84fd5120b1eb79c6b52c16bea508761041c1732cb04f0d34a',
     x86_64: '2961c41e2a8676ab3f92f3873b0b39b195d834da07ee030607c91ed4ee04476d',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
