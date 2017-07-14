require 'package'

class A2ps < Package
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'http://www.gnu.org/software/a2ps/'
  version '4.14'
  source_url 'http://ftp.gnu.org/gnu/a2ps/a2ps-4.14.tar.gz'
  source_sha256 'f3ae8d3d4564a41b6e2a21f237d2f2b104f48108591e8b83497500182a3ab3a4'

  depends_on 'gperf'
  depends_on 'filecmd'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

