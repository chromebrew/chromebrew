require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.21.1-1'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.21.1.tar.lz'
  source_sha256 '53ae95b7ac8b6f6996a85076cf4f7c8b32c8c4027387b7b989dd0796333c8c8f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-1_armv7l/gettext-0.21.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-1_armv7l/gettext-0.21.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-1_i686/gettext-0.21.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1-1_x86_64/gettext-0.21.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ae343c77d3dc15372a64a3e021f0e817f8395ea130f80f8be9cf6d9ecc4d769',
     armv7l: '1ae343c77d3dc15372a64a3e021f0e817f8395ea130f80f8be9cf6d9ecc4d769',
       i686: '2fa088b31d8f3c9eb431970622e8bbadb07561757b101ac2945c7644bb05fab4',
     x86_64: '83cc3753be3095b11c262ae8562cbb5147c59cfccce5a9bec04932698257638f'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'openjdk8' => :build
  depends_on 'openmp' => :build
  depends_on 'zlibpkg' # R
  # depends_on 'openmp' # R This is only needed for the msgmerge binary.
  no_env_options

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system '[ -x configure ] || ./autogen.sh'
    system 'filefix'
    system "CC=clang CXX=clang++ ./configure #{CREW_OPTIONS} \
      --disable-static \
      --enable-shared \
      --with-pic \
      --without-included-gettext"
    system 'make'
  end

  def self.check
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
