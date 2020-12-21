require 'package'
  
class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.3.0.tar.gz'
  source_sha256 'e1cb1db3d2e249a6a3eb6f0946777c2e892d5c5dc7bd91c74394fc3a01cab8b5'



  def self.build
    system 'autoreconf -i -f'
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
