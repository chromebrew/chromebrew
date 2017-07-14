require 'package'

class Patch < Package
  description 'Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions.'
  homepage 'http://savannah.gnu.org/projects/patch/'
  version '2.7.5'
  source_url 'https://ftp.gnu.org/gnu/patch/patch-2.7.5.tar.xz'
  source_sha256 'fd95153655d6b95567e623843a0e77b81612d502ecf78a489a4aed7867caa299'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
