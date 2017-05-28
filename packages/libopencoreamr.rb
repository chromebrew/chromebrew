require 'package'

class Libopencoreamr < Package
  version '0.1.5'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz'
  source_sha1 'bef4d1e3a8a155b47569b6691a223843b33e279e'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
