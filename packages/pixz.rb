# Adapted from Arch Linux pixz PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/pixz/trunk/PKGBUILD

require 'package'

class Pixz < Package
  description 'Parallel, indexed xz compressor'
  homepage 'https://github.com/vasi/pixz'
  version '1.0.7-0829-2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/vasi/pixz.git'
  git_hashtag '0829c7315c804a4e40abd63a9d624194dc1e4f0a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-2_armv7l/pixz-1.0.7-0829-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-2_armv7l/pixz-1.0.7-0829-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-2_i686/pixz-1.0.7-0829-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-2_x86_64/pixz-1.0.7-0829-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5da3b2e16b0708721ddb223729255c566ee673c970a8114fda18e1d647c226ba',
     armv7l: '5da3b2e16b0708721ddb223729255c566ee673c970a8114fda18e1d647c226ba',
       i686: '52467f9b204170592fec0abd34a54a67b0fcf2b25f850c1548da1c7ed1762e0e',
     x86_64: '40f515777f3285e3cc37b4c5f91a68d857eb3c46707e916cb1248c15180f8da0'
  })

  depends_on 'asciidoc' => :build
  depends_on 'libarchive'
  depends_on 'xzutils'
  no_patchelf

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
