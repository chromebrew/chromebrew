require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  @_ver = '0.21'
  version "#{@_ver}-2"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gettext/gettext-#{@_ver}.tar.lz"
  source_sha256 '435b546e3880ab767c967c0731b20629a0cb0ba620e6bac2f590f401c10ebb45'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-2_armv7l/gettext-0.21-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-2_armv7l/gettext-0.21-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-2_i686/gettext-0.21-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gettext/0.21-2_x86_64/gettext-0.21-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0c4ba6f36d8c248903ab10ab34859ef7894ed943b5b75f0f7f989cafa3b3396f',
     armv7l: '0c4ba6f36d8c248903ab10ab34859ef7894ed943b5b75f0f7f989cafa3b3396f',
       i686: '1b8b246ad1bc3b4fd463e91b93b82e4f69479642f1bf27332d82be2809617f39',
     x86_64: '4ada2428329f3fc4098b4fab8cc81d816028a7ac283c359c86fdc1d569a52af3'
  })

  depends_on 'jdk8' => :build
  depends_on 'openmp'

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
