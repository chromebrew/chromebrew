require 'package'

class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8'
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'
  source_sha256 '0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
