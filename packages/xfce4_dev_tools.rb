require 'package'

class Xfce4_dev_tools < Package
  description 'Xfce4 development tools'
  homepage 'https://xfce.org/'
  version '4.14.0'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.14/xfce4-dev-tools-4.14.0.tar.bz2'
  source_sha256 '2c9eb8e0fe23e47dc31411a93b683fd1b7a49140e9163f0aab9e94a3d8a0b5fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_dev_tools-4.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_dev_tools-4.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_dev_tools-4.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_dev_tools-4.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8b1ceccfed1a4bdb34dbf9ed35c246cca5035754ae01185db88261cd5ed62dd4',
     armv7l: '8b1ceccfed1a4bdb34dbf9ed35c246cca5035754ae01185db88261cd5ed62dd4',
       i686: 'fe79c7ae95dc08eb4a32168d8b0ff5fcd203cd91d7b12d894a94f826d84dd425',
     x86_64: '24341f2465119626d4625ba9926f7d63f7e6a95bba6f18e01706025855399c9e',
  })

  depends_on 'gtk_doc'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
