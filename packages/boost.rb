require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.64.0'
  source_url 'https://downloads.sourceforge.net/project/boost/boost/1.64.0/boost_1_64_0.tar.bz2'
  source_sha256 '7bcc5caace97baa948931d712ea5f37038dbb1c5d89b43ad4def4ed7cb683332'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.64.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.64.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.64.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.64.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cc806a211d2d5e54f57828632d9e75618aec7a79d59d86b37d273c87ce49a602',
     armv7l: 'cc806a211d2d5e54f57828632d9e75618aec7a79d59d86b37d273c87ce49a602',
       i686: '34b64d136a7ca2f9601d25b79d2a353e8216d8c9a00cdb065abdb329e6126eba',
     x86_64: '6500636fca4b7dd36bd36d819e686c1c2416709502660cfe477714072f0e2733',
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_DIR}#{CREW_PREFIX} --libdir=#{CREW_DEST_DIR}#{CREW_LIB_PREFIX} install"
  end
end
