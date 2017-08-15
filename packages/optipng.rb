require 'package'

class Optipng < Package
  description 'OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.'
  homepage 'http://optipng.sourceforge.net/'
  version '0.7.6-1'
  source_url 'http://prdownloads.sourceforge.net/optipng/optipng-0.7.6.tar.gz'
  source_sha256 '4870631fcbd3825605f00a168b8debf44ea1cda8ef98a73e5411eee97199be80'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/optipng-0.7.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/optipng-0.7.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/optipng-0.7.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/optipng-0.7.6-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cbec93e41fa2aaf0c5ff8b56a532236f88ba16f7dd4c56bfa8f04e67a801f224',
     armv7l: 'cbec93e41fa2aaf0c5ff8b56a532236f88ba16f7dd4c56bfa8f04e67a801f224',
       i686: '1f5b21f33c91191c1aa53d387948b9dd83bb38ee196b94439dd91b3a05602c5d',
     x86_64: '15a053ff2d6728d49f9c33301963a342aa385c94184be494a15f3d14daa7928f',
  })

  depends_on 'libpng'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=/usr/local --with-system-libpng" # Bundled libpng doesn't work on armv7l
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
