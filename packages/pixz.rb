# Adapted from Arch Linux pixz PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/pixz/trunk/PKGBUILD

require 'package'

class Pixz < Package
  description 'Parallel, indexed xz compressor'
  homepage 'https://github.com/vasi/pixz'
  version '1.0.7-f1b1b5f'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/vasi/pixz.git'
  git_hashtag 'f1b1b5f8af68d0ac782e5ff24f11785282382f40'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e4155b71de92416f5e3be2e6fdb142e789bdabc8d6a631ae8f5e1e185bfbab5e',
     armv7l: 'e4155b71de92416f5e3be2e6fdb142e789bdabc8d6a631ae8f5e1e185bfbab5e',
       i686: '4a99c8ad086d11276fc6d74d14c83cd9fed9ad64601b0ac6fa8ad2b4a80e967f',
     x86_64: 'aa0c005b74a688982f0282833846879d6fbac02a28dadf69ebb0ded6924f096c'
  })

  depends_on 'asciidoc' => :build
  depends_on 'libarchive'
  depends_on 'xzutils'
  no_patchelf
  no_zstd

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env manpage=true \
      ./configure \
      CC=clang LD=ld.lld  CFLAGS='-flto -pipe -O3 -fuse-ld=lld -static' \
      CXXFLAGS='-flto -pipe -O3 -static' \
      LDFLAGS='-flto -static' \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
