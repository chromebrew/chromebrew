require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.2'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.2.2.tar.bz2'
  source_sha256 'd8e853d8805574777bbe40937812ad1419c9ea7210e176f0def3e6ed255ab3ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f20836e7392c095c013f60d797f4baafeb45cbca294a8c18f65f3e4b6254f177',
     armv7l: 'f20836e7392c095c013f60d797f4baafeb45cbca294a8c18f65f3e4b6254f177',
       i686: 'fb5eac7b44ff2281f11c6ca0868111d082d52c426bf233b096db43966fc77411',
     x86_64: '69c2ad1f9f67af8573f63f79c2e44072d521aad1497ebf1197c668d22fddfec4',
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
