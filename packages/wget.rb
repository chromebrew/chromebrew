require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.19.5'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.19.5.tar.lz'
  source_sha256 '29fbe6f3d5408430c572a63fe32bd43d5860f32691173dfd84edc06869edca75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '35587c27c9750f198bdab2867e41e7f06296c50de68287d0d58facab8c5fb1e0',
     armv7l: '35587c27c9750f198bdab2867e41e7f06296c50de68287d0d58facab8c5fb1e0',
       i686: 'b87c6a0ba84f08875205e232f85eb75e548201554887800ccbc8b5e5aa5f8bbe',
     x86_64: '548eed614937bab283230225992d52d7760e76f2b1aeb5f0e605419bdb9b0439',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
