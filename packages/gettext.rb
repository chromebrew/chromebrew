require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  @_ver = '0.21'
  version "#{@_ver}-1"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gettext/gettext-#{@_ver}.tar.lz"
  source_sha256 '435b546e3880ab767c967c0731b20629a0cb0ba620e6bac2f590f401c10ebb45'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-1_armv7l/gettext-0.21-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-1_armv7l/gettext-0.21-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-1_i686/gettext-0.21-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-1_x86_64/gettext-0.21-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6d54ddacd45c8393893173a163b24a0b1ece327fce41b0e37d9353fd203360e7',
     armv7l: '6d54ddacd45c8393893173a163b24a0b1ece327fce41b0e37d9353fd203360e7',
       i686: '829a5256d748faaa93b6c5ff7ea142940536b40189222d6d0d4fba888eac0131',
     x86_64: '25deed7e58cba619b5c9efae12aaec377823b28dcf8d70340c41a8604fd8365f'
  })

  depends_on 'jdk8' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS} \
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
