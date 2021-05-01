require 'package'

class Libxfixes < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '5.0.3-1'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfixes-5.0.3.tar.gz'
  source_sha256 '9ab6c13590658501ce4bd965a8a5d32ba4d8b3bb39a5a5bc9901edffc5666570'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/5.0.3-1_armv7l/libxfixes-5.0.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/5.0.3-1_armv7l/libxfixes-5.0.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/5.0.3-1_i686/libxfixes-5.0.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/5.0.3-1_x86_64/libxfixes-5.0.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '053fad492759a5dd5df72239a28416fa93e64f84ebc49e26ce1a410924345463',
     armv7l: '053fad492759a5dd5df72239a28416fa93e64f84ebc49e26ce1a410924345463',
       i686: '0ee965d91984d4aceff29cc3859cff2d1c1df3badf824cbe09c350004e367873',
     x86_64: '7c1ea8c44eceafccacbbb99b7ffceb641aec47d063e5f4cd65b44defc1b721e8',
  })

  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
