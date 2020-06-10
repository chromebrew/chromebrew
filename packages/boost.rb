require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version '1.71.0'
  compatibility 'all'
  source_url 'https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.bz2'
  source_sha256 'd73a8da01e8bf8c7eda40b4c84915071a8c8a0df4a6734537ddde4a8580524ee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.71.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.71.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.71.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.71.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e0d2c1c299cff64f8d7f8de806cc8bfb2dce0be992d037cf17967bf4e9795e46',
     armv7l: 'e0d2c1c299cff64f8d7f8de806cc8bfb2dce0be992d037cf17967bf4e9795e46',
       i686: 'f000df2868e43bcab73d09d6fc7b161ef8b4ae433809dec3d8943b375aa36982',
     x86_64: '7d028e7fab5e95a2cbc74eb8b86de0d77619f652c83e687b4ae0e491baed3e5d',
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
