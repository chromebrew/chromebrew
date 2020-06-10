require 'package'

class Nanomsg < Package
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.1.5'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg/archive/1.1.5.tar.gz'
  source_sha256 '218b31ae1534ab897cb5c419973603de9ca1a5f54df2e724ab4a188eb416df5a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70871fc6e26bbb62ed2924c9f368f9dae4395a7c03306ccfd00d01fcae196c03',
     armv7l: '70871fc6e26bbb62ed2924c9f368f9dae4395a7c03306ccfd00d01fcae196c03',
       i686: 'fed0e57269bae6898436d906b38cc36751aa1abd3c786810168ad9f673d002c8',
     x86_64: 'fbe6018ba37354fb102a78ec63c0aef7a36f0e1e34b0bf19355e3e912df498c2',
  })

  def self.build
    FileUtils.mkdir('build')
    FileUtils.cd('build') do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                       -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.check
    FileUtils.cd('build') do
      system 'ctest .'
    end
  end
end
