
require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  compatibility 'all'
  version '3.27.90'
  source_url 'https://github.com/GNOME/yelp-xsl/archive/3.27.90.tar.gz'
  source_sha256 '26df38777769031fbe5fa641e5656d69ebea81098f7627ab677f59dd91f523d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.27.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.27.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.27.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-3.27.90-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7bc40594bafb4b9ba4fc4f52a0563e70655f4ba8cf30bcb7acd8a80d7d01c2ca',
     armv7l: '7bc40594bafb4b9ba4fc4f52a0563e70655f4ba8cf30bcb7acd8a80d7d01c2ca',
       i686: '1e2c1fa0da42c8ff8909b89c18720f235ffcd9f1baa5f5ed581aac8ea30068b9',
     x86_64: 'c3be835828187766de18110d03f8daed3a7700cdd6aada7e1334042e6a8d0143',
  })

  depends_on 'itstool'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
