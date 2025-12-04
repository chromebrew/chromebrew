# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version "0.17.1-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{version.split('-').first}.tar.gz"
  source_sha256 '362971e0f32dc1905f6fe4736319c4b8348c22dc85aa6c3f690a28efe548029e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c8a896207a86c536fc21ccafd75351a87d2685af933686c8acd3f531498c1ca',
     armv7l: '0c8a896207a86c536fc21ccafd75351a87d2685af933686c8acd3f531498c1ca',
       i686: '0fec5b27e1c26c6d62bafe4fff459ef2bade43d719e9eac725b777ca9bcdb39a',
     x86_64: 'dc83bbfe1958e69fa9a5509853489a0b731285efc3b60a3ddf50af5c0edf627e'
  })

  depends_on 'cmocka' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' => :build
  depends_on 'talloc' # R

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
