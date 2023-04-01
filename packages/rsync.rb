require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.2.7'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://rsync.samba.org/ftp/rsync/src/rsync-3.2.7.tar.gz'
  source_sha256 '4e7d9d3f6ed10878c58c5fb724a67dacf4b6aac7340b13e488fb2dc41346f2bb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.7_armv7l/rsync-3.2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.7_armv7l/rsync-3.2.7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.7_i686/rsync-3.2.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.7_x86_64/rsync-3.2.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c3d7f3a8422896e5c0695d9b31415631fecac77402448297e461c39fc0207a7d',
     armv7l: 'c3d7f3a8422896e5c0695d9b31415631fecac77402448297e461c39fc0207a7d',
       i686: 'b45b006511bb54f04504a2b38983948cf9423f80484c8d39df3713b945c77cd8',
     x86_64: '1186347920dbad663f280a059bda3bbc1bf5dabc4a6f5dcc4befa20e9a01265e'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  no_patchelf
  no_zstd

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
