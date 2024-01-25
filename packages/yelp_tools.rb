require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '42.1'
  license 'GPL-2+ or freedist and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-tools/-/archive/#{version}/yelp-tools-#{version}.tar.bz2"
  source_sha256 '40aadae0c6f0af41f90bcaba532d20b5b401476d64b2650aa419ef6264c00ecd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70792bf80c6bb3f66c959acdad595a2ff08fef8de990e41b700f74d0ae6a931e',
     armv7l: '70792bf80c6bb3f66c959acdad595a2ff08fef8de990e41b700f74d0ae6a931e',
       i686: 'eee77db471affeb7110d6c4cff18a1d4ea624d58803420a5654a4f3442fa2d07',
     x86_64: 'dec4d9bac63673a7fa572d7006d2f139caa4d10da8c1b965e36719135755a99d'
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'py3_lxml'

  def self.patch
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g' tools/*.in"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
