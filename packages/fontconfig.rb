require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.12.4'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.4.tar.bz2'
  source_sha256 '668293fcc4b3c59765cdee5cee05941091c0879edcc24dfec5455ef83912e45c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.12.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9019600344fb674b24c24b78599cb9ad45f5b33cfd3d3e31c2a3b8c87895f67',
     armv7l: 'e9019600344fb674b24c24b78599cb9ad45f5b33cfd3d3e31c2a3b8c87895f67',
       i686: '0d970e13d571ebeb4963ed1b50d9943502117877b2e08168613a0e705bf48211',
     x86_64: '96dd1f4f9b381f3670d706a7ab0ed83cb48d354f1a5690a22d24929655dbc7ef',
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
