# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version "2.4.4-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version.split('-').first}.tar.gz"
  source_sha256 '55e47994018c13743485544e7206780ffbb3c8495e704a99636503e6e77abf59'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acf42cbf0a6f6899ef3f5f4991b72165a63260c4ea01d770023087833705adb6',
     armv7l: 'acf42cbf0a6f6899ef3f5f4991b72165a63260c4ea01d770023087833705adb6',
       i686: '01ef37db3070f05ed572e37744ebcecd4ac6804629518e011d6b57fb696473e3',
     x86_64: '401afdb3ef9a1bd98a365279fbcf70c20402fd254d24eb9662a37790329391a1'
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
