require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  @_ver = '1.35.0'
  version "#{@_ver}-4"
  license 'GPL-2+-with-openssl-exception'
  compatibility 'all'
  source_url "https://github.com/aria2/aria2/releases/download/release-#{@_ver}/aria2-#{@_ver}.tar.xz"
  source_sha256 '1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aria2/1.35.0-4_armv7l/aria2-1.35.0-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aria2/1.35.0-4_armv7l/aria2-1.35.0-4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aria2/1.35.0-4_i686/aria2-1.35.0-4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aria2/1.35.0-4_x86_64/aria2-1.35.0-4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1392fa2c405ec1ef2c0c92da6b6efb58c5de78eef173106e608480df121e4d22',
     armv7l: '1392fa2c405ec1ef2c0c92da6b6efb58c5de78eef173106e608480df121e4d22',
       i686: '16ad82df538c4bea9a2d3af51c67e80a5e09b73f4b03e6ae2bb4e50b70ffacfd',
     x86_64: '4cf9736c53e380a6dd3bdede7f85d91866285f392c7eee7acfebb83a7b1b0ef4',
  })

  depends_on 'cppunit' => :build
  depends_on 'libgcrypt'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS}
     ./configure #{CREW_OPTIONS} \
      --with-libnettle \
      --with-libgcrypt \
      --disable-dependency-tracking \
      --without-libssh2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
