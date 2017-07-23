require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.12.4'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.4.tar.bz2'
  source_sha256 '668293fcc4b3c59765cdee5cee05941091c0879edcc24dfec5455ef83912e45c'

  depends_on 'gperf'
  depends_on 'pkgconfig'
  depends_on 'freetype'

  def self.build
      system './configure CFLAGS=" -fPIC" --localstatedir=/usr/local/cache'
      system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
