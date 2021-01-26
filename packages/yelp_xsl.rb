
require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  compatibility 'all'
  version '3.38.2'
  source_url 'https://github.com/GNOME/yelp-xsl/archive/3.38.2.tar.gz'
  source_sha256 'd9e9cc02fc7bb442601515c68fccc4bfbee69860166ca318be9e6b37525943ad'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.38.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.38.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.38.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.38.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3dfe0bdcddbbdc0bd1cd85890919bdec6962d24894fe39db49686c5655d61674',
      armv7l: '3dfe0bdcddbbdc0bd1cd85890919bdec6962d24894fe39db49686c5655d61674',
        i686: 'f3a4d2c7155e43b8a43e8188686abfa3e5a195e6479325f5172fa2192ef84977',
      x86_64: '652e4331e8a136bf3f492618c372063ae86b9feddb407f1edca24fec4362027b',
  })

  depends_on 'itstool'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
