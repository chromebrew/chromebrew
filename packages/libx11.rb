require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.12-1'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.12.tar.bz2'
  source_sha256 'f108227469419ac04d196df0f3b80ce1f7f65059bb54c0de811f4d8e03fd6ec7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.12-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.12-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.12-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.12-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd715d29d6f7d8de9ee49bb702d2d971ce5b71e85d51fb98aa96b49768ab7d742',
     armv7l: 'd715d29d6f7d8de9ee49bb702d2d971ce5b71e85d51fb98aa96b49768ab7d742',
       i686: 'e06833cfde25b822fdf7d2268d5be63dcb7f443c26fdb2b2bf45ee60f396d95d',
     x86_64: 'a2d9bb3e29dd747039cb83ed329bc09723bde68c6c92398212fda8f317a3fbd2',
  })

  depends_on 'llvm' => ':build'
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
