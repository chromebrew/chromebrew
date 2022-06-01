# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version '2.3.3'
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version}.tar.gz"
  source_sha256 '6be95b2368bd0af1c4cd7a88146eb6ceea18e46c3ffc9330bf6262b40d1d8aaa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.3_armv7l/talloc-2.3.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.3_armv7l/talloc-2.3.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.3_i686/talloc-2.3.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.3_x86_64/talloc-2.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a723d57e1400894c112f6480effb852195b9d1edd56ca6692b42747d56af0b80',
     armv7l: 'a723d57e1400894c112f6480effb852195b9d1edd56ca6692b42747d56af0b80',
       i686: 'c8c43903f11e03ef117f72e3ddf9d4fe4f5ffe1e800f9789001fb049d51c480a',
     x86_64: '983230c12d39e40265a18aebd25440bd6561d7cc09327622555c4674df438d8c'
  })

  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'docbook_xsl' => :build

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
