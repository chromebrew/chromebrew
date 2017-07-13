require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.59.0'
  source_url 'http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz'
  source_sha256 '47f11c8844e579d02691a607fbd32540104a9ac7a2534a8ddaef50daf502baac'

  def self.build
    system './bootstrap --prefix=/usr/local'
  end

  def self.install
    system './b2 install'
  end
end
