require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.3.5-0'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.3.5.tar.bz2'
  source_sha256 '41444fd7a6ff73a79ad9728f985e71c9ba8cd3e5e53358e70d5f066d35c1a340'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libksba-1.3.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libksba-1.3.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libksba-1.3.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libksba-1.3.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9992a30c1ec084d843db72b5d183f46e65596ab52925b1807b1c7476dfa0f071',
     armv7l: '9992a30c1ec084d843db72b5d183f46e65596ab52925b1807b1c7476dfa0f071',
       i686: 'e69de6e5e76ae483bc8c350eb3ad9ab9cc1f03b1680c05bef2ea2acb4a4dc993',
     x86_64: '4c0a4853f87105315ae990d0ccc6450bab22dd40666a92d0a22985b301739833',
  })

  depends_on 'libgpgerror'
  depends_on 'npth'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
