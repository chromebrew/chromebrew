require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.22'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.22.tar.lz'
  source_sha256 '24e2669b23abf26f9afdbbc3055edeb33879fb36454de80e8e4aadb3dbbe0b96'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22_armv7l/gettext-0.22-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22_armv7l/gettext-0.22-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22_i686/gettext-0.22-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.22_x86_64/gettext-0.22-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3808f2fdd880d2f8bc33179773ca14c3bf67d8e90faecd176d561bc88d35f8b4',
     armv7l: '3808f2fdd880d2f8bc33179773ca14c3bf67d8e90faecd176d561bc88d35f8b4',
       i686: '41286e5a6b2fe8d6c59589a963d161cc8e18c261c85f2d61c82fca94a5c8ecdd',
     x86_64: '83325934f7695541f53f9ec84e5e5ffa35a3cdbf1b7607d4e17532f6567812fb'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'openjdk8' => :build
  depends_on 'zlibpkg' # R

  no_env_options

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
      --disable-static \
      --enable-shared \
      --with-pic \
      --without-included-gettext"
    system 'make'
  end

  def self.check
    # FAIL: test-u8-conv-from-enc
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
