# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'buildsystems/autotools'

class Talloc < Autotools
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version "2.5.0-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version.split('-').first}.tar.gz"
  source_sha256 '912afa237510ae542a7733998eb18a12bcda35ab6729c8e2ddb43e8d0ebab007'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adf3581f6f13d7204665416c113a0c8996e60c393dc3cf8ace5a05e8a2c4c717',
     armv7l: 'adf3581f6f13d7204665416c113a0c8996e60c393dc3cf8ace5a05e8a2c4c717',
       i686: 'e104e0e57cca7ab93eb77a2a6d6ea78682d455daf9c5ab664f04539b79abfddb',
     x86_64: '0d8a1563840cf4e83c5fdb1a14cd99f270e8be083e925c1f6c3b6f11fd2039ad'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxcrypt' => :build
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
end
