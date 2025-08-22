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
    aarch64: '4a28a359182ba4d965efe075fc3aa1d2c5553cb11e12eac3ec13d05a2a70308c',
     armv7l: '4a28a359182ba4d965efe075fc3aa1d2c5553cb11e12eac3ec13d05a2a70308c',
       i686: '0fec5b27e1c26c6d62bafe4fff459ef2bade43d719e9eac725b777ca9bcdb39a',
     x86_64: '26f6631813e764fd2fccaf938b69e228cb9092ce6d8d0df898b469019d82ceb9'
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
