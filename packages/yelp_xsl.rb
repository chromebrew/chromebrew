require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '40.0'
  license 'GPL-2+, LGPL-2.1+, MIT and FDL-1.1+'
  license 'GPL-2+ or freedist and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/yelp-xsl/-/archive/#{version}/yelp-xsl-#{version}.tar.bz2"
  source_sha256 '3938ae88880cdcc3bbd20db25a05bac03cd1324d60c2940ed85e56259725e7f7'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/yelp_xsl-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/yelp_xsl-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/yelp_xsl-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/yelp_xsl-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd98fe7c598a54bee90907294bca5ab24732ecbe3f2badc0953693e88007e49ba',
     armv7l: 'd98fe7c598a54bee90907294bca5ab24732ecbe3f2badc0953693e88007e49ba',
       i686: 'abe1c586c597739747c831fbf5a7ee7fe6658d519250d0404ce3bbfda2509c1f',
     x86_64: 'b23d398de5907823b21dc15f0eba4ec6d6da33d9e42c399c48d8e36de4188d2d'
  })

  depends_on 'itstool'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
