# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  @_ver = '2.4.2'
  version "#{@_ver}-py3.12"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{@_ver}.tar.gz"
  source_sha256 '85ecf9e465e20f98f9950a52e9a411e14320bc555fa257d87697b7e7a9b1d8a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ee5aeb4503273f040e9eafaed78c165483104bb4094388bbb30c73f81ed1aac',
     armv7l: '5ee5aeb4503273f040e9eafaed78c165483104bb4094388bbb30c73f81ed1aac',
       i686: 'd8c78c96bbf613563a33e67c9c596ab7dd52d6674f637a011d5eaa990928bcda',
     x86_64: 'b5a52d24807c58504aca03626a5d2964ef4834250b0b7ad817997b88214e1376'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
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
