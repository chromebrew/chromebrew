require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.2.3'
  compatibility 'all'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.2.3.tar.gz'
  source_sha256 'becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cc3dafbe2332746b08f3c3c88ae5ec72ad33e0889055264cceae90905e368f14',
     armv7l: 'cc3dafbe2332746b08f3c3c88ae5ec72ad33e0889055264cceae90905e368f14',
       i686: 'f107cf84d70674007a950b9cfef59e5e7683713f8b02ed8d4aaedb4225a032d9',
     x86_64: 'b6c07acfcfc6b71b508ca1068d3374af6ed4858a7aed638628fa5ca6c1ddb071',
  })

  depends_on 'zstd'
  depends_on 'lz4'
  depends_on 'xxhash'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
