require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.0'
  source_url 'https://github.com/vitalif/grive2/archive/v0.5.0.tar.gz'
  source_sha256 '24641ef4802eb93bb55e7069bca55c4fb8aa17fd88833b9c89a1b2ee7d266567'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'yajl'
  depends_on 'curl'
  depends_on 'libgcrypt'
  depends_on 'boost'
  depends_on 'expat'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
