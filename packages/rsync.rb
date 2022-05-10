require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  @_ver = '3.2.4'
  version @_ver.to_s
  license 'GPL-3'
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 '6f761838d08052b0b6579cf7f6737d93e47f01f4da04c5d24d3447b7f2a5fad1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4_armv7l/rsync-3.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4_armv7l/rsync-3.2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4_i686/rsync-3.2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.4_x86_64/rsync-3.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a2a22a25d50fe400ddb6cd525abbfea05f82fb36e2da0dd6550402b8a0529327',
     armv7l: 'a2a22a25d50fe400ddb6cd525abbfea05f82fb36e2da0dd6550402b8a0529327',
       i686: 'f78152b34b3ccfb798f890ac78a8174f03bf27fe750fb747576e5274f3f3045f',
     x86_64: '78d02794bbea0bfc750a4f216eb855b43179b22d0c0366119544692c0881b160'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
