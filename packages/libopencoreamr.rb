require 'package'

class Libopencoreamr < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.5-0'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz'
  source_sha256 '2c006cb9d5f651bfb5e60156dbff6af3c9d35c7bbcc9015308c0aff1e14cd341'



  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
