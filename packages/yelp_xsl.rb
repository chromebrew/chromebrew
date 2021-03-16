require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '40.rc'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-xsl/archive/40.rc.tar.gz'
  source_sha256 'f158b5c899b32267dee796146deb8c2831272aa66bbe3cc103031b2ddd182fc8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '945153ad9d4bea36d348411382dfbd5a6d492c491e17afb7f059901c6805d486',
     armv7l: '945153ad9d4bea36d348411382dfbd5a6d492c491e17afb7f059901c6805d486',
       i686: 'b5c6b4ac0658eac4717204b3c0a99d947a884a470b34b04251bb8214ce831547',
     x86_64: '5f03c4a1a5606b16cfc8bdd4d421b01b222fe6368c04c9837eaeb9671598aed9'
  })

  depends_on 'itstool'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
