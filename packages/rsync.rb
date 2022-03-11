require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  @_ver = '3.2.3'
  version "#{@_ver}-2"
  license 'GPL-3'
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 'becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.3-2_armv7l/rsync-3.2.3-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.3-2_armv7l/rsync-3.2.3-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.3-2_i686/rsync-3.2.3-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.3-2_x86_64/rsync-3.2.3-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ba288d6e49f3bef27932e810d58206b1c3c8c60bfb5ef3168bbded428ee89a0b',
     armv7l: 'ba288d6e49f3bef27932e810d58206b1c3c8c60bfb5ef3168bbded428ee89a0b',
       i686: '6eb5c8f79b5e29ad461f833738db4251bfbadb037ab2ea8030ed3516e709c1a4',
     x86_64: '7f8006dc3358106d7f949b8a344746cc7b445c03bb9640238b1d48322f5c07ae'
  })

  depends_on 'xxhash'
  depends_on 'lz4'
  depends_on 'popt'
  depends_on 'zstd'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
