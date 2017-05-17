require 'package'

class Patch < Package
  version '2.7'
  source_url 'http://ftp.gnu.org/gnu/patch/patch-2.7.tar.gz'
  source_sha1 '8886fe94a4cefaf42678ebeca25f4c012bd0f5dc'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
