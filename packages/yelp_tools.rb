require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '40.alpha'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-tools/archive/40.alpha.tar.gz'
  source_sha256 '24a7b7f6e48f52935049732eae729fbbd7bcb45b413b620c9b51ea058cddd7ee'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.alpha-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.alpha-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.alpha-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.alpha-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '78e2341e954e05cca61b8221de01996e8a0817ace9476c83143593c0668d12e7',
     armv7l: '78e2341e954e05cca61b8221de01996e8a0817ace9476c83143593c0668d12e7',
       i686: 'dc7cf4e135dd0e84e1da4189c7514d4915d93c3e960d79bcb185ab223625a51b',
     x86_64: '1cb4bc720a7cd8b4845dcf832458ecf2fd1096f3fb156d9266bb215f867f5588'
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'lxml'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
