require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version '1.71.0'
  source_url 'https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.bz2'
  source_sha256 'd73a8da01e8bf8c7eda40b4c84915071a8c8a0df4a6734537ddde4a8580524ee'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
