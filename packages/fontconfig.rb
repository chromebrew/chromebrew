require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.14.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/2.14.0/fontconfig-2.14.0.tar.bz2'
  source_sha256 'e89a0c6868771b88de27bd20cd98f1056a3083666a1cf7c85d26ac5c67cc25a8'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_armv7l/fontconfig-2.14.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_armv7l/fontconfig-2.14.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_i686/fontconfig-2.14.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_x86_64/fontconfig-2.14.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '99c5724f5a53e7ba476b4fb5dfbec97632608fc28afb39a26f0ea394b6b8ca86',
     armv7l: '99c5724f5a53e7ba476b4fb5dfbec97632608fc28afb39a26f0ea394b6b8ca86',
       i686: 'fce56b685e312d9754c3376c6ff8ed83f7cc99154da5f6a913d2d76c9b8736c2',
     x86_64: 'ea6e16d4505be56cbb9ed5a0b971e1df7f34c8ddd9e6c160cda62c8f30ca6af2',
  })

  depends_on 'expat'
  depends_on 'jsonc'
  depends_on 'gperf'
  depends_on 'freetype'
  depends_on 'libpng'
  depends_on 'util_linux'
  depends_on 'graphite'

  no_fhs

  def self.build
    system "./autogen.sh #{CREW_OPTIONS} --localstatedir=#{CREW_PREFIX}/cache"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # The following are included the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
