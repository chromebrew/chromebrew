require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'http://www.boost.org/'
  version '1.66.0'
  source_url 'https://downloads.sourceforge.net/project/boost/boost/1.66.0/boost_1_66_0.tar.bz2'
  source_sha256 '5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.66.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.66.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.66.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.66.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2dbbe25f491f89c331ad9a7f36a2ffbc245db4621d43b5beb0772f07dfc8704c',
     armv7l: '2dbbe25f491f89c331ad9a7f36a2ffbc245db4621d43b5beb0772f07dfc8704c',
       i686: '193afe14c196b23424caa03c845ffba12390cfbf84248f94398494502e7be7f3',
     x86_64: '527a50ab5e9dc7420a63f5ee6f3826ab9816f7f65ab2e87f54ac4cef9b452d67',
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
