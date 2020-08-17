require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.3.2'
  compatibility 'all'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.2.3.tar.bz2'
  source_sha256 '02f00922fc511eaf37b037197afa930d5ff0912c1a86f333393f91f3426f678e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.build
    system './configure',
           '--without-debug',
           '--disable-maintainer-mode',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-pythonlibs=-lpython3.8',
           "--with-pythonincludes=-I#{CREW_PREFIX}/include/python3.8"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
