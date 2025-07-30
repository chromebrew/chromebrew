# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version "2.4.3-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version.split('-').first}.tar.gz"
  source_sha256 '85ecf9e465e20f98f9950a52e9a411e14320bc555fa257d87697b7e7a9b1d8a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1619aeed34e6ef39470a26f70d063b527950a9d97d3f09bc4eb0f9bb3366c29d',
     armv7l: '1619aeed34e6ef39470a26f70d063b527950a9d97d3f09bc4eb0f9bb3366c29d',
       i686: '0efa7e4bb5effc9461cb6ad682fd5aa2b19f993bdbd47aa08ed6cca082530a3a',
     x86_64: '61cddcc6102531dd5395a6372ad425a45967bc2906f35e96b6157b32568a02c3'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  # depends_on 'python3' # R (optional) # For Python bindings.
  depends_on 'python3' => :build

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')} \
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
