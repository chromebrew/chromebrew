require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '3.38.0-7e610'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-tools/archive/7e610eb8d5d2fd8dfc28778ce1516a7b1bff6dc3.zip'
  source_sha256 '752092e3961cfeaedb074daec7f2ef3b0c0d8bc01085290cf4be5cac6ecf37dc'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.38.0-7e610-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.38.0-7e610-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.38.0-7e610-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.38.0-7e610-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c22699371d46c6391823f9d8c1f45d6bb40e4e399605f6632ed2e6fb6d18afb4',
      armv7l: 'c22699371d46c6391823f9d8c1f45d6bb40e4e399605f6632ed2e6fb6d18afb4',
        i686: 'a0dc8a85a65e2a4f1f8020a3616898fe8dd1a065ad2ab6f4524d155d8053b4d1',
      x86_64: '613ad6fa579f87899b5562d16c0dc425f98646f2596ec36188771e9bc86cfe61',
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
