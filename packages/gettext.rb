require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.21.1'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gettext/gettext-0.21.1.tar.lz'
  source_sha256 '53ae95b7ac8b6f6996a85076cf4f7c8b32c8c4027387b7b989dd0796333c8c8f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1_armv7l/gettext-0.21.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1_armv7l/gettext-0.21.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1_i686/gettext-0.21.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21.1_x86_64/gettext-0.21.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '351a7a13f1f1a788d544bab4805d7b6100cd5db44f39ec99c1872d1a459d05d8',
     armv7l: '351a7a13f1f1a788d544bab4805d7b6100cd5db44f39ec99c1872d1a459d05d8',
       i686: '95ca3c205f9bb33a5ab362cf2095b159807e094a9357040f05c9211b01104af0',
     x86_64: '9f3d76554b800278b04718bec4e792848d4af052aa732c85beeafcedd58f8201'
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

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
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
