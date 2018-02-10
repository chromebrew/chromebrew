require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.12.2'
  source_url 'https://www.cairographics.org/releases/cairomm-1.12.2.tar.gz'
  source_sha256 '45c47fd4d0aa77464a75cdca011143fea3ef795c4753f6e860057da5fb8bd599'

  depends_on 'cairo'
  depends_on 'libsigcplusplus'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/cairomm-1.12.2/' \
    -i docs/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
