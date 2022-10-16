require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '42.0'
  license 'GPL-2+ or freedist and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-tools/-/archive/#{version}/yelp-tools-#{version}.tar.bz2"
  source_sha256 'c71a7b10adb91712887c96541ce6eedf7c6f68d0cd1fa67bce0b27c46c3b2b05'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_tools/42.0_armv7l/yelp_tools-42.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_tools/42.0_armv7l/yelp_tools-42.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_tools/42.0_i686/yelp_tools-42.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_tools/42.0_x86_64/yelp_tools-42.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bdf45b19f8c95e000cb32ca96f0b17946177487a1294f5812cb200e3a4d94a58',
     armv7l: 'bdf45b19f8c95e000cb32ca96f0b17946177487a1294f5812cb200e3a4d94a58',
       i686: '8431a64a6b7790d78fad98baf9cbddcf129cebe130f337a111f62310b147a7da',
     x86_64: 'e513576b06f6d6d2a027e120e3dcfb3774fd9222e47d69a4749f0ed3db67b9f8'
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'py3_lxml'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
