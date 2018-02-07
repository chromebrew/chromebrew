
require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documen'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '3.27.90'
  source_url 'https://github.com/GNOME/yelp-xsl/archive/3.27.90.tar.gz'
  source_sha256 '26df38777769031fbe5fa641e5656d69ebea81098f7627ab677f59dd91f523d6'

  depends_on 'perl_xml_parser'
  depends_on 'gettext'
  depends_on 'itstool'
  depends_on 'libxml2'
  depends_on 'intltool' => :build
  depends_on 'automake' => :build

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
