# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  @_ver = '2.4.0'
  version "#{@_ver}-py3.11"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{@_ver}.tar.gz"
  source_sha256 '6df36862c42466ef88f360444513870ef46934f9016c84383cc4008a7d0c46ba'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.0-py3.11_armv7l/talloc-2.4.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.0-py3.11_armv7l/talloc-2.4.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.0-py3.11_i686/talloc-2.4.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.0-py3.11_x86_64/talloc-2.4.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dbc0444cb4c44182fdf5399a99d77d11535a320cb869836e62d196db94ef4a66',
     armv7l: 'dbc0444cb4c44182fdf5399a99d77d11535a320cb869836e62d196db94ef4a66',
       i686: 'd16f2054972dba8b8ce0efb4915afee3d6bda0c5fc2dd0cbc9debdc081fd0d53',
     x86_64: 'f7f03601c25b6d7cfb0a6b12443cdb68ecdd24b3d0e04c9649260f89aaf530a7'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' # R

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace \
      --enable-talloc-compat1"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
