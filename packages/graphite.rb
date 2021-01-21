require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '1.3.14-1'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz'
  source_sha256 'f99d1c13aa5fa296898a181dff9b82fb25f6cc0933dbaa7a475d8109bd54209d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ee1594a2f5a0349dd12ef28fb60dffe254c8ca3ac4444da7be90741057c63b5',
     armv7l: '3ee1594a2f5a0349dd12ef28fb60dffe254c8ca3ac4444da7be90741057c63b5',
       i686: '772269f953a7ddb6a40d164bf405f2e0219a0d6dc805efe8a0df5b9840769fb2',
     x86_64: '1eac00455f2ff39b9ed26689054a5794e62fa7c4b8eacf1c5cb4a839c3d01ac5',
  })

  depends_on 'freetype_sub'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_LIBSUFFIX_OPTIONS} .."
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
