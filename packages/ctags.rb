require 'package'

class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8-0'
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'
  source_sha256 '0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7'


  def self.build
   system "./configure  --prefix=#{CREW_PREFIX}  --libdir=#{CREW_LIB_PREFIX}"
   system "make"
  end

  def self.install
    #system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"  # it does not work here
    system "install -D755 ctags #{CREW_DEST_PREFIX}/bin/ctags"
    system "gzip -9 ctags.1"
    system "install -D644 ctags.1.gz #{CREW_DEST_PREFIX}/share/man/man1/ctags.1.gz"
  end
end
