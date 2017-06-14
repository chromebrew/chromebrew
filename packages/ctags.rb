require 'package'
 
class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8'
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'
  source_sha1 '482da1ecd182ab39bbdc09f2f02c9fba8cd20030'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
