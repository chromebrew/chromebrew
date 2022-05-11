require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  @_ver = '3.2.4'
  version "#{@_ver}-1"
  license 'GPL-3'
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 '6f761838d08052b0b6579cf7f6737d93e47f01f4da04c5d24d3447b7f2a5fad1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4-1_armv7l/rsync-3.2.4-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4-1_armv7l/rsync-3.2.4-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4-1_i686/rsync-3.2.4-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4-1_x86_64/rsync-3.2.4-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2a4989c4fa43820963420a96d3e09ce59ed4f34e65663445bd0f1769de404396',
     armv7l: '2a4989c4fa43820963420a96d3e09ce59ed4f34e65663445bd0f1769de404396',
       i686: 'd093d62e8a946f2adefa5b68fd542e04323b7e541f8a3e7e73ca6ad87af2348a',
     x86_64: 'aac8a471eea2128805b2323353e9d856f95bf49ff3258be83dc859c226e95b44'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'xxhash' # R
  depends_on 'zstd' # R
  no_patchelf

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
