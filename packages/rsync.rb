require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.2.3'
  compatibility 'all'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.2.3.tar.gz'
  source_sha256 'becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "zstd"
  depends_on "lz4"
  depends_on "xxhash"

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
