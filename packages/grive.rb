require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.0'
  source_url 'https://github.com/vitalif/grive2/archive/v0.5.0.tar.gz'
  source_sha256 '24641ef4802eb93bb55e7069bca55c4fb8aa17fd88833b9c89a1b2ee7d266567'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/grive-0.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea606c3ae5c87ff65ad07f2b3923f39cd645286aaad59af6892feda6ae73c3d3',
     armv7l: 'ea606c3ae5c87ff65ad07f2b3923f39cd645286aaad59af6892feda6ae73c3d3',
       i686: '23155b411e631f29d3a9564c58ccee91a359adf5f493a08a8db87923457acde1',
     x86_64: '5a463602100a35662a1353615f76ae0db082ad6b3d98f17fdecccb8d2c2a1869',
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
