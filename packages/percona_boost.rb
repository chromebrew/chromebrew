require 'package'

class Percona_boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.59.0'
  source_url 'http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.bz2'
  source_sha256 '727a932322d94287b62abb1bd2d41723eec4356a7728909e38adb65ca25241ca'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
