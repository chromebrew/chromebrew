require 'package'

class Augeas < Package
  description 'Augeas is a configuration editing tool that parses native formats and transforms them into a tree.'
  homepage 'http://augeas.net/'
  version '1.12.0'
  compatibility 'all'
  source_url 'http://download.augeas.net/augeas-1.12.0.tar.gz'
  source_sha256 '321942c9cc32185e2e9cb72d0a70eea106635b50269075aca6714e3ec282cb87'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/augeas-1.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/augeas-1.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/augeas-1.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/augeas-1.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c77e2c9e36dff045129f4e196b72051e7e085c612d43fe0f3f3f8d825c9d3ad',
     armv7l: '8c77e2c9e36dff045129f4e196b72051e7e085c612d43fe0f3f3f8d825c9d3ad',
       i686: 'ef2cc58fb25c5273ba50adfbbf6c577b2c13b79ecb325da15367965847dfba0d',
     x86_64: 'fb85f457590f5b10d786e80b1a177f0942628438de38f64f7ae15856ee753b2c',
  })

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
