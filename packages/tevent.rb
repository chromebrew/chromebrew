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
    aarch64: 'f067e62f5b9e37cf57838678b9d73828918e33e22fc231a376ab1256d20da397',
     armv7l: 'f067e62f5b9e37cf57838678b9d73828918e33e22fc231a376ab1256d20da397',
     x86_64: '9178285cbb6088533569aa4c042700e2f1e2e50174a849c077fdeefa12b923e5'
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
