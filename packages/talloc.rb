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
    aarch64: '6a39df0ca1191342d76f7f4ae7d108f9c33d5b27834541c32529d56f2bcb3547',
     armv7l: '6a39df0ca1191342d76f7f4ae7d108f9c33d5b27834541c32529d56f2bcb3547',
       i686: '90472b76ee72650033c302168d71a2ae23154d84583d554906a10039ad94cae0',
     x86_64: '40e36519b57f33feeae188636bc3510f6f3ae1cf982640de7da134c5e6f970ea'
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
