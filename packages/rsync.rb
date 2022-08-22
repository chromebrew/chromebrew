require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  @_ver = '3.2.5'
  version '3.2.5-1'
  license 'GPL-3'
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 '2ac4d21635cdf791867bc377c35ca6dda7f50d919a58be45057fd51600c69aba'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5-1_armv7l/rsync-3.2.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5-1_armv7l/rsync-3.2.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5-1_i686/rsync-3.2.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5-1_x86_64/rsync-3.2.5-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ccab29052cafb1d0e315b9a2b6e48ee48300a761c3a980ae97f657dae6455679',
     armv7l: 'ccab29052cafb1d0e315b9a2b6e48ee48300a761c3a980ae97f657dae6455679',
       i686: '89cdf0532d7761809f87339aa762357c8777b87a43960db15028183f004c9c07',
     x86_64: 'ad8c1503ed103c594390ac3497c4dc982ef2906a3290de2783a0ee6f10b764cb'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'xxhash' # R
  depends_on 'zstd' # R
  no_env_options
  no_patchelf
  no_zstd

  def self.build
    @rsync_env_options = CREW_ENV_OPTIONS.gsub('CFLAGS="',
                                                'CFLAGS="-static ').gsub('LDFLAGS="',
                                                'LDFLAGS="-Wl,--whole-archive -lpthread -Wl,--no-whole-archive ')
    system "#{@rsync_env_options} ./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
