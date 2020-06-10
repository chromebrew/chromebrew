require 'package'

class Cryptsetup < Package
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.0.3'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/utils/cryptsetup/v2.0/cryptsetup-2.0.3.tar.xz'
  source_sha256 '4d6cca04c1f5ff4a68d045d190efb2623087eda0274ded92f92a4b6911e501d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '336db165a18055d522037b89e90dc97a2c967e3c4c14a84b77a2effb2b6f8618',
     armv7l: '336db165a18055d522037b89e90dc97a2c967e3c4c14a84b77a2effb2b6f8618',
       i686: 'ba83377debf5b8716b568b594d60546fa6fd0987241409592cc2a4e8bb659503',
     x86_64: '38500360185a743c7421c19863b902917445da3e7fb5cff2001fbffc16d58e70',
  })

  depends_on 'util_linux'
  depends_on 'lvm2'
  depends_on 'jsonc'
  depends_on 'libgcrypt'
  depends_on 'popt'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
