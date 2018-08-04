require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.6'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.6.tar.bz2'
  source_sha256 '5f2cd274b272cae0d0d111e8a9e363f08783329157e8dd68b3de0c096de6d724'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
