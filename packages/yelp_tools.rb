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
    aarch64: '346bc52c050fc19c822aea860ee73d017a738ee74f8dbbdf3710ec0f52480fae',
     armv7l: '346bc52c050fc19c822aea860ee73d017a738ee74f8dbbdf3710ec0f52480fae',
       i686: '1534b7273cf516f371b11203ac7b2cda478754d26b155a295ae18f264f714cdf',
     x86_64: '67191036eaff541ae39d3da6f9d1b4b70c45944bcbac429d4a9e949b586ad4d1'
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
