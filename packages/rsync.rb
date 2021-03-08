require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  @_ver = '3.2.3'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 'becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.2.3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a005ade8a7e03d1fcfb7b122c7db6ffd48ca759ff21d70dbf5d57eee26661f34',
     armv7l: 'a005ade8a7e03d1fcfb7b122c7db6ffd48ca759ff21d70dbf5d57eee26661f34',
       i686: '0c1b8db87c84c849710705b4f07fc75edf78d998056c97025dcc6e55de775a8f',
     x86_64: '507cbeaafce02f9c0c55f378abae7e4fe7814ac29ad000f99aae1f2978caa1bd'
  })

  depends_on 'xxhash'
  depends_on 'lz4'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
