require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '1.3.14-2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz'
  source_sha256 'f99d1c13aa5fa296898a181dff9b82fb25f6cc0933dbaa7a475d8109bd54209d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/1.3.14-2_armv7l/graphite-1.3.14-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/1.3.14-2_armv7l/graphite-1.3.14-2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/1.3.14-2_x86_64/graphite-1.3.14-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4b7ccb98e54afb311014eedeaee7a262cc8d46c0ee9ca4102cc5aee8a38660e0',
     armv7l: '4b7ccb98e54afb311014eedeaee7a262cc8d46c0ee9ca4102cc5aee8a38660e0',
     x86_64: '298e03f04acb71d5b8fdfb340b0bc6387fe4ecf2ac2b0ebad7ecb21101c85e66'
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
