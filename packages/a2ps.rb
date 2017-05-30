require "package"

class A2ps < Package
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'http://www.gnu.org/software/a2ps/'
  version "4.14"
  source_url "http://ftp.gnu.org/gnu/a2ps/a2ps-4.14.tar.gz"
  source_sha1 "365abbbe4b7128bf70dad16d06e23c5701874852"

  depends_on "gperf"
  depends_on "filecmd"

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

