require 'package'

class Clzip < Package
  description 'Clzip is a drop-in implementation of lzip written in C.'
  homepage 'https://www.nongnu.org/lzip/clzip.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/clzip/clzip-1.12.tar.gz'
  source_sha256 'fcc92b3006d87b7c4affa03fe9dcc4869a802253052653200c26f6ba718bfee8'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clzip/1.12_armv7l/clzip-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clzip/1.12_armv7l/clzip-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clzip/1.12_i686/clzip-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clzip/1.12_x86_64/clzip-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '11e571bffba4f5e076a01bd29c8faf0061fe177d6be7b6ca5d49a9940bf2052c',
     armv7l: '11e571bffba4f5e076a01bd29c8faf0061fe177d6be7b6ca5d49a9940bf2052c',
       i686: 'a95b75946a575012bb11742e00753eeb15ae587824c614744860da16552604f9',
     x86_64: '2a2083ef64d799cb7350769d6950817ee2a0784e06b514efcc9e8b6a826d067d',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              CC=#{CREW_TGT}-gcc \
              CFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
