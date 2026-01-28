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
  source_sha256 'dc46c40b9f46bb34dd97fe41f548b0e8b247b77a918576733c528e83abd854dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a5b293bef4c93f2f465ffc256675cbfd87d3e298056be9e07ee54c4fa30ceba',
     armv7l: '7a5b293bef4c93f2f465ffc256675cbfd87d3e298056be9e07ee54c4fa30ceba',
       i686: '4c2786124d376ed6293f5773361c8e7034f6cb4b4a23899bcaa2590afd5a2867',
     x86_64: 'c7a68cfff1881c1eb38620d6a3bec18aa0ba2b6b027d0e156fa7938e262c17a8'
  })

  # depends_on 'python3' # R (optional) # For Python bindings.
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' # R

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
