# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'buildsystems/autotools'

class Tevent < Autotools
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  version "0.17.3-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://samba.org/ftp/tevent/tevent-#{version.split('-').first}.tar.gz"
  source_sha256 '8eaa1b1b8d3c36ce8ddeae6d79c9a05360dcba5930115112c078415bcbe0d16d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdf747e11b86182b14464bfda0cbf16e1b9cafd101491851cd5320268358f0dc',
     armv7l: 'cdf747e11b86182b14464bfda0cbf16e1b9cafd101491851cd5320268358f0dc',
     x86_64: '7810b05e46424a8e84c2cbfe12a6c167d94765288e957bb7995a56f090fb9114'
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
