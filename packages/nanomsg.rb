require 'package'

class Nanomsg < Package
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.1.5'
  source_url 'https://github.com/nanomsg/nanomsg/archive/1.1.5.tar.gz'
  source_sha256 '218b31ae1534ab897cb5c419973603de9ca1a5f54df2e724ab4a188eb416df5a'

  binary_url ({
  })
  binary_sha256 ({
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
