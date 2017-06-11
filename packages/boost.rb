require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.59.0'
  source_url 'http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz'
  source_sha1 '5123209db194d66d69a9cfa5af8ff473d5941d97'

  def self.build
    system './bootstrap --prefix=/usr/local'
  end

  def self.install
    system './b2 install'
  end
end
