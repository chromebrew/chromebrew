require 'package'

class Augeas < Package
  description 'Augeas is a configuration editing tool that parses native formats and transforms them into a tree.'
  homepage 'http://augeas.net/'
  version '1.12.0'
  source_url 'http://download.augeas.net/augeas-1.12.0.tar.gz'
  source_sha256 '321942c9cc32185e2e9cb72d0a70eea106635b50269075aca6714e3ec282cb87'

  binary_url ({
  })
  binary_sha256 ({
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
