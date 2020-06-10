require 'package'

class Libcroco < Package
  description 'Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit.'
  homepage 'https://git.gnome.org/browse/libcroco/'
  version '0.6.12'
  compatibility 'all'
  source_url 'http://ftp.gnome.org/pub/gnome/sources/libcroco/0.6/libcroco-0.6.12.tar.xz'
  source_sha256 'ddc4b5546c9fb4280a5017e2707fbd4839034ed1aba5b7d4372212f34f84f860'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcroco-0.6.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcroco-0.6.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcroco-0.6.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcroco-0.6.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1997e3255d0cc8495c869a6f1de7dc9e6b7e83c066bf9fda0c07d8d808b59a2a',
     armv7l: '1997e3255d0cc8495c869a6f1de7dc9e6b7e83c066bf9fda0c07d8d808b59a2a',
       i686: '913d41daf21e307c5c06d04d82b0f55e3a14fa31baf552475380217748ba3455',
     x86_64: '21b8c0b44777da7c607c08b85732f1a91a805f248a1937351f4c92ec50444975',
  })

  depends_on 'gtk_doc'
  depends_on 'six' => :build

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
