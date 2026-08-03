# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version "2.5.0-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version.split('-').first}.tar.gz"
  source_sha256 '912afa237510ae542a7733998eb18a12bcda35ab6729c8e2ddb43e8d0ebab007'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f935cfeed12e65bcb6e05487c4aea4028a309fe0b3f51ba819477b4d7012d32',
     armv7l: '0f935cfeed12e65bcb6e05487c4aea4028a309fe0b3f51ba819477b4d7012d32',
       i686: 'faa8301a42aa8d2807fa9b57ed962016ea096e307274e5277f79df924af43e57',
     x86_64: '12345a378867013afc0df87cff96d51a3ca66493e503a9583ab96361985c81ec'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxcrypt' => :build
  # depends_on 'python3' # R (optional) # For Python bindings.
  depends_on 'python3' => :library

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
