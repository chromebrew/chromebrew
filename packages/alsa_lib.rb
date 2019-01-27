require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.8'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.8.tar.bz2'
  source_sha256 '3cdc3a93a6427a26d8efab4ada2152e64dd89140d981f6ffa003e85be707aedf'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.build
    system './configure',
           '--without-debug',
           '--enable-mixer-pymods',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
           '--with-pythonlibs=-lpython3.7m'
           "--with-pythonincludes=-I#{CREW_PREFIX}/include/python3.7m"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
