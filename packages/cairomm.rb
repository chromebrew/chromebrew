require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.12.2'
  source_url 'https://www.cairographics.org/releases/cairomm-1.12.2.tar.gz'
  source_sha256 '45c47fd4d0aa77464a75cdca011143fea3ef795c4753f6e860057da5fb8bd599'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '888898b832f6d43a3810caf17de63dbca0380914febcfada5210a36d839d8097',
     armv7l: '888898b832f6d43a3810caf17de63dbca0380914febcfada5210a36d839d8097',
       i686: '3781427ed44646a23045843d73ce1bdb85eb9b9a12a0130c7726ea7afa23dd50',
     x86_64: '94dfeb48047f9d9cb2ebda72c640dbe64532f2d4496f8c0dd7bfc2aea91b42ae',
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
