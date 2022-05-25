require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '42.1'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-xsl/-/archive/#{version}/yelp-xsl-#{version}.tar.bz2"
  source_sha256 '81b8d626a1481d542fb8c9cb890fa970ddc42b27f7779d52df31c4de0caac776'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_armv7l/yelp_xsl-42.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_armv7l/yelp_xsl-42.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_i686/yelp_xsl-42.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yelp_xsl/42.1_x86_64/yelp_xsl-42.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2155ec95428055623c569db0dabe9fc91349aa011f83ce61acec26df2deb27e3',
     armv7l: '2155ec95428055623c569db0dabe9fc91349aa011f83ce61acec26df2deb27e3',
       i686: 'ff4a7cf7247e6a477bbac643b4e446d4ce45a32da1014673236e9764acc8d46c',
     x86_64: '03e70d4b552cb539c1799f1709bf22c20ddcb281b508c462aa146db023f9801c'
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
