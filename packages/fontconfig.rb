require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.12.4-1'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.4.tar.bz2'
  source_sha256 '668293fcc4b3c59765cdee5cee05941091c0879edcc24dfec5455ef83912e45c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34f5212e583b5c6c993ccdf4d2f0252e276a18328492a336a483c066f640dd55',
     armv7l: '34f5212e583b5c6c993ccdf4d2f0252e276a18328492a336a483c066f640dd55',
       i686: '9ab6f59b64fd27f81b2d30d01da4b29c94bf1e60a0e4d87f8ca1cda5f22b9386',
     x86_64: 'dc136fe2a61688e9ec461682627c6475b7918bcc0f6584e5ff27649791629e8f',
  })

  depends_on 'expat'
  depends_on 'gperf'
  depends_on 'pkgconfig'
  depends_on 'freetype'

  def self.build
      system './configure CFLAGS=" -fPIC" --localstatedir=/usr/local/cache'
      system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
