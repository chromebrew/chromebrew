require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  @_ver = '1.15.1'
  version @_ver
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{@_ver}.tar.bz2"
  source_sha256 'eebc3c1b27f1c8979896ff361ba9bb4778b508b2496c2fc10e3775a40b1de1ad'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.15.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cefc164ba4ee3297c69c23c247c48cc26aea6f8bf060ff428d03d3288bffbffb',
     armv7l: 'cefc164ba4ee3297c69c23c247c48cc26aea6f8bf060ff428d03d3288bffbffb',
       i686: '828ebe648f313eb3849d0fc1b09f287159ec658438b0917d2cea9938da173924',
     x86_64: '63a1accd77f24e417dc9ca519a142303d2083f1fa49af2bb3edb6b3fc08e0677'
  })

  depends_on 'gnupg'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
