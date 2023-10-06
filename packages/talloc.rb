# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  @_ver = '2.4.1'
  version "#{@_ver}-py3.12"
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{@_ver}.tar.gz"
  source_sha256 '410a547f08557007be0e88194f218868358edc0ab98c98ba8c167930db3d33f9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.1-py3.12_armv7l/talloc-2.4.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.1-py3.12_armv7l/talloc-2.4.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.1-py3.12_i686/talloc-2.4.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.4.1-py3.12_x86_64/talloc-2.4.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a529ad100187f9ec5d7646d18dfb6ea8232748399007f84a053651443063c35d',
     armv7l: 'a529ad100187f9ec5d7646d18dfb6ea8232748399007f84a053651443063c35d',
       i686: '0f5fce2f0c8c5e4109241ae40b73312dd9995888a200a44c7ce04bfb10096974',
     x86_64: '2c549eaadd8029a4ad1a715ac0fae3ede35ed41f3ed7447094237fcb2c01a75d'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' # R

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
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
