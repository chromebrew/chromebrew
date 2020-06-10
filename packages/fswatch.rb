require 'package'

class Fswatch < Package
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.11.2'
  compatibility 'all'
  source_url 'https://github.com/emcrisostomo/fswatch/releases/download/1.11.2/fswatch-1.11.2.tar.gz'
  source_sha256 'b7dadb84848ce666aac0311f9b4c739fbfee6a90c6097807a1f45ad4367294c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fswatch-1.11.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fswatch-1.11.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fswatch-1.11.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fswatch-1.11.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '216b35bc050f6daa298f6da0074f70542898d22647dc6340434664cf75359518',
     armv7l: '216b35bc050f6daa298f6da0074f70542898d22647dc6340434664cf75359518',
       i686: 'c067271949e1a7c8c3d9baf074fe5e63879359aa94c1a3aa0d39bede0f53d389',
     x86_64: '672356d1260e94fb9b430b49ac20c384333974de7b85006f865de4e3244a3e71',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
