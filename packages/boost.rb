require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.66.0'
  source_url 'https://downloads.sourceforge.net/project/boost/boost/1.66.0/boost_1_66_0.tar.bz2'
  source_sha256 '5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9'

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
