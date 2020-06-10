require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.12.2-1'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/cairomm-1.12.2.tar.gz'
  source_sha256 '45c47fd4d0aa77464a75cdca011143fea3ef795c4753f6e860057da5fb8bd599'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24b1da59d5156446baa4b524a194cb1f1f446b9377452e83b132127b3b4bfe1f',
     armv7l: '24b1da59d5156446baa4b524a194cb1f1f446b9377452e83b132127b3b4bfe1f',
       i686: 'd37adb6a92ba92cccfc58a70b868b2e2deab20f8b397bfdb2ba2ee30f8310623',
     x86_64: 'd5510efba06f2543a15761be7b9d7a08f980db22022f84b011436f1faf787b33',
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'

  def self.build
    system "sed -e '/^libdocdir =/ s/$(book_name)/cairomm-1.12.2/' \
    -i docs/Makefile.in"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
