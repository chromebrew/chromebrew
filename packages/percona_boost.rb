require 'package'

class Percona_boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.59.0'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.bz2'
  source_sha256 '727a932322d94287b62abb1bd2d41723eec4356a7728909e38adb65ca25241ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_boost-1.59.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/percona_boost-1.59.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/percona_boost-1.59.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_boost-1.59.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8ae7d1682a5801169991b3d824402059ea7b527ca1b118dca240d9a91201fd1',
     armv7l: 'a8ae7d1682a5801169991b3d824402059ea7b527ca1b118dca240d9a91201fd1',
       i686: '92bf850fafa7e11eee4040faf615ac97f31e8e561016d4fcbfa97d9ef6931452',
     x86_64: '4cfcf14440dae594c3ad0c8fa3086f08c0e90787785d82e1b54454bcf0941ed9',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
