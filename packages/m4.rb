require 'package'

class M4 < Package
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.18-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/m4/m4-1.4.18.tar.xz'
  source_sha256 'f2c1e86ca0a404ff281631bdc8377638992744b175afb806e25871a24a934e07'

  depends_on 'libsigsegv'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.symlink 'm4', 'gm4'
    end
  end

  def self.check
    system "make check"
  end
end
