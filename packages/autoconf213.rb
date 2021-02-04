require 'package'

class Autoconf213 < Package
  description 'A GNU tool for automatically configuring source code Legacy 2.1x version'
  homepage 'https://www.gnu.org/software/autoconf/'
  version '2.13'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz'
  source_sha256 'f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf213-2.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf213-2.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf213-2.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf213-2.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '43464c65466ff94bb507a3174ddd0d325dd0e02d9ffe76a2575d44a795c8f699',
     armv7l: '43464c65466ff94bb507a3174ddd0d325dd0e02d9ffe76a2575d44a795c8f699',
       i686: 'c47998526c952a872745218099bf240c5e3105064608202cb8c2730186f4163b',
     x86_64: '732cdb8cc6bd9be3847fca42713da472f83032a13322efb9eb19e4a23a9e9338'
  })

  depends_on 'perl'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --infodir=#{CREW_PREFIX}/share/info \
      --program-suffix=-2.13 \
      -datadir=#{CREW_PREFIX}/share/autoconf213"
    system 'make'
  end

  def self.install
    system "make prefix=#{CREW_DEST_PREFIX} infodir=#{CREW_DEST_PREFIX}/share/info install"
  end
end
