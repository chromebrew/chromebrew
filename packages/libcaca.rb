require 'package'

class Libcaca < Package
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'https://github.com/cacalabs/libcaca'
  version '0.99.beta20-e496'
  license 'GPL-2, ISC, LGPL-2.1 and WTFPL'
  compatibility 'all'
  source_url 'https://github.com/cacalabs/libcaca/archive/e4968ba6e93e9fd35429eb16895c785c51072015.zip'
  source_sha256 'e44aa1a77d4345809d317063ca82e9247867dd9147069dd2fa0fe6db8411e395'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta20-e496-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta20-e496-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta20-e496-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta20-e496-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ab3310aa860fc7ec1f52300dbf2089052dbabda6ebcd991666e8000cad16658e',
     armv7l: 'ab3310aa860fc7ec1f52300dbf2089052dbabda6ebcd991666e8000cad16658e',
       i686: 'ba1650734ebfff4563b6e1a50ef58d8fa60ae5425f79127290e7af81a7b4a7d9',
     x86_64: 'b108a838bc825089b20da633c9a759e42071eb6137ef1effb0f9297d9cbbf3c5'
  })

  depends_on 'freeglut'
  depends_on 'imlib2'
  depends_on 'jdk8' => :build
  depends_on 'libglu'
  depends_on 'libx11'
  depends_on 'mesa'

  def self.build
    system '[ -x configure ] || ./bootstrap'
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto'
      ./configure \
      #{CREW_OPTIONS} \
      --enable-gl \
      --enable-ncurses \
      --enable-network \
      --enable-slang \
      --enable-x11"

    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
