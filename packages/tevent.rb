# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'buildsystems/autotools'

class Tevent < Autotools
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version "0.17.2-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://samba.org/ftp/tevent/tevent-#{version.split('-').first}.tar.gz"
  source_sha256 'e53b1ac288d017d66dde0471cd429a806168ecf07179d7f019572d7a7e05f0d6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a454be0a7c8dbc6e7b3043b156c57a2d0a8151c7d1935101f245004f7e968785',
     armv7l: 'a454be0a7c8dbc6e7b3043b156c57a2d0a8151c7d1935101f245004f7e968785',
     x86_64: '599e4d4ed0fc8f572c008d33b732da9077acf464dd5e96c403344853cbdf3f7d'
  })

  depends_on 'cmocka' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxcrypt' => :build
  depends_on 'python3' => :build
  depends_on 'talloc' => :library

  autotools_skip_configure

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end
end
