require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.64.0'
  source_url 'https://downloads.sourceforge.net/project/boost/boost/1.64.0/boost_1_64_0.tar.bz2'
  source_sha256 '7bcc5caace97baa948931d712ea5f37038dbb1c5d89b43ad4def4ed7cb683332'

  def self.build
    system './bootstrap.sh --prefix=/usr/local'
  end

  def self.install
    system './b2 -a'
  end
end
