require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '3.27.90'
  source_url 'https://github.com/GNOME/yelp-tools/archive/3.27.90.tar.gz'
  source_sha256 'da584450bc2373d1a27a922e851f88256c49c9a49a15ed2762e493f37b52a692'

  depends_on 'yelp_xsl'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
