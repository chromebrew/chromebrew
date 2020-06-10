require 'package'

class Ladspa < Package
  description 'Linux Audio Developer\'s Simple Plugin API'
  homepage 'https://www.ladspa.org/'
  version '1.15'
  compatibility 'all'
  source_url 'https://www.ladspa.org/download/ladspa_sdk_1.15.tgz'
  source_sha256 '4229959b09d20c88c8c86f4aa76427843011705df22d9c28b38359fd1829fded'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ladspa-1.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ladspa-1.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ladspa-1.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ladspa-1.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3aa308850f574ef1151a8bddfb1056775b81752a0e33e9da37eb1884c0261223',
     armv7l: '3aa308850f574ef1151a8bddfb1056775b81752a0e33e9da37eb1884c0261223',
       i686: 'bd9075f52a19d34a86f0674e9c33a14587006939760145ed1588937795e31315',
     x86_64: 'c1f1d2875ea96794b51bd542768687ec3c8514abec0c3f9600a8dbb967a2df83',
  })

  def self.patch
    Dir.chdir('src') do
      system 'sed', '-i', '-e', "s,/usr,\$(DESTDIR)#{CREW_PREFIX},g", '-e', "s,lib,#{ARCH_LIB},", 'Makefile'
    end
  end

  def self.build
    Dir.chdir('src') do
      system 'make'
    end
  end

  def self.install
    Dir.chdir('src') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
