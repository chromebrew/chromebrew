# Adapted from Arch Linux pixz PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/pixz/trunk/PKGBUILD

require 'package'

class Pixz < Package
  description 'Parallel, indexed xz compressor'
  homepage 'https://github.com/vasi/pixz'
  version '1.0.7-0829-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/vasi/pixz.git'
  git_hashtag '0829c7315c804a4e40abd63a9d624194dc1e4f0a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-1_armv7l/pixz-1.0.7-0829-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-1_armv7l/pixz-1.0.7-0829-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-1_i686/pixz-1.0.7-0829-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixz/1.0.7-0829-1_x86_64/pixz-1.0.7-0829-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2260deb2b1748041fe31c2d2f858837ae0a63d4d7a432e0cc8c926539f9d6b7f',
     armv7l: '2260deb2b1748041fe31c2d2f858837ae0a63d4d7a432e0cc8c926539f9d6b7f',
       i686: '47dc38370dc228123e8666b5d1c01c47f13b049b40c8b5492c76104322415e04',
     x86_64: 'b0ad21a8d1f7a3c3e27deac1977b8d7a1c6d82bc5a9a22c4bc266d390cd76657'
  })

  depends_on 'asciidoc' => :build
  depends_on 'libarchive'
  depends_on 'xzutils'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env manpage=true \
      ./configure \
      CC=clang LD=ld.lld \
      CFLAGS='-flto -pipe -O3 -fuse-ld=lld -static' \
      CXXFLAGS='-flto -pipe -O3 -static' \
      LDFLAGS='-flto -static' \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
