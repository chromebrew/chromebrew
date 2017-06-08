require 'package'

class Libfdkaac < Package
  description 'A standalone library of the Fraunhofer FDK AAC code from Android.'
  homepage 'https://github.com/mstorsjo/fdk-aac/'
  version '0.1.5'
  source_url 'https://github.com/mstorsjo/fdk-aac/archive/v0.1.5.tar.gz'
  source_sha1 '2894bd6d21066bfdf65a2f8cb6d2ca2dde597194'

  depends_on 'automake'

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
