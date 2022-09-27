require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '42.1'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-xsl/-/archive/#{version}/yelp-xsl-#{version}.tar.bz2"
  source_sha256 '81b8d626a1481d542fb8c9cb890fa970ddc42b27f7779d52df31c4de0caac776'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_armv7l/yelp_xsl-42.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_armv7l/yelp_xsl-42.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_i686/yelp_xsl-42.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_x86_64/yelp_xsl-42.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e810c6a62d3cf9c4f8c6c84db68bf11dc7ac365f1cde52fc7b8d008555b98f0b',
     armv7l: 'e810c6a62d3cf9c4f8c6c84db68bf11dc7ac365f1cde52fc7b8d008555b98f0b',
       i686: 'c58481f38cda9854f946d770b777ec7e689c2da76013c5d3ee57fa980ac92f08',
     x86_64: '1defdb536455b497cd8c761a0ce1872bb9f6f1560a9d0846796337b8d2045d66'
  })

  depends_on 'itstool'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
