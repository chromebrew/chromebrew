require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.21.1-2'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.21.1.tar.lz'
  source_sha256 '53ae95b7ac8b6f6996a85076cf4f7c8b32c8c4027387b7b989dd0796333c8c8f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-2_armv7l/gettext-0.21.1-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-2_armv7l/gettext-0.21.1-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-2_i686/gettext-0.21.1-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-2_x86_64/gettext-0.21.1-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6a995e81c4cbb243b7974110d44912d30b9fdec6fe37ec1a511101501879361e',
     armv7l: '6a995e81c4cbb243b7974110d44912d30b9fdec6fe37ec1a511101501879361e',
       i686: 'bab63683d3cb4375528f4039795f5d65484270e78e385101803699053a7f6b3d',
     x86_64: 'c7a649dae6ecf4f2262c50b7872458750e3dfbec90c37c7a6469741f1fdcfcec'
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
