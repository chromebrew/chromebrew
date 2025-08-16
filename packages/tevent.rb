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
    aarch64: 'eb797ce3effa14924747bc7c70aba3ff1f778bad976a3e3e75ec181d88066f78',
     armv7l: 'eb797ce3effa14924747bc7c70aba3ff1f778bad976a3e3e75ec181d88066f78',
       i686: 'e8ed5f70e19c964bb4763656440ddebb8e036ad862ef13288ea39695b710d9c3',
     x86_64: '5db2c5713601b02cddcebb783fc52a38b2fb9fdd9f4621bb010b961b4a066564'
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
