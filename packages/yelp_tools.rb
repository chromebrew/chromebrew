require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '40.0'
  license 'GPL-2+ or freedist and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-tools/-/archive/#{version}/yelp-tools-#{version}.tar.bz2"
  source_sha256 'bada2afb5160066aef39e11f90eb5377f0bb161aa2b4dcd744c381e3c2ff77ce'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/yelp_tools-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/yelp_tools-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/yelp_tools-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/yelp_tools-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1317a7aa14db9fd3f3794ece39708c35320b2098a3265dfaad0b7d1e418b0319',
     armv7l: '1317a7aa14db9fd3f3794ece39708c35320b2098a3265dfaad0b7d1e418b0319',
       i686: '86378c2ee8f256700d241c977cf676c45607f0733bcdd811fa138ddc7114e834',
     x86_64: '2c039b5bbc4aacf02f8e6892ce52e2cc334144c769b44ea2251429f2d91fc677'
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'lxml'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
