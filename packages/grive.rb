require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.0-1'
  compatibility 'all'
  source_url 'https://github.com/vitalif/grive2/archive/v0.5.0.tar.gz'
  source_sha256 '24641ef4802eb93bb55e7069bca55c4fb8aa17fd88833b9c89a1b2ee7d266567'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e42ae9643925d4500328fecc1149f24c7dbaa1ccc6c8ec4129b408ad6cbaeb02',
     armv7l: 'e42ae9643925d4500328fecc1149f24c7dbaa1ccc6c8ec4129b408ad6cbaeb02',
       i686: 'b037829746c3ead4eb3e344a09c7feaf2c0f252264d157269175d7103d85b740',
     x86_64: '294e6a0dbe20fd737982d99014d688a3fe648e18a3703324faefd0daffe3d524',
  })

  depends_on 'yajl'
  depends_on 'curl'
  depends_on 'libgcrypt'
  depends_on 'boost'
  depends_on 'expat'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DPREFIX=#{CREW_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
      system "ln -s #{CREW_LIB_PREFIX}/libbfd.so #{CREW_DEST_LIB_PREFIX}/libbfd-2.25.51.20141117.so"
    end
  end
end
