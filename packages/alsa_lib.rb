require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.3.2'
  compatibility 'all'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.2.3.2.tar.bz2'
  source_sha256 'e81fc5b7afcaee8c9fd7f64a1e3043e88d62e9ad2c4cff55f578df6b0a9abe15'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba12c44ff01c904da7270ced35819e490f53b95c15199c36ae5f02867a9fc421',
     armv7l: 'ba12c44ff01c904da7270ced35819e490f53b95c15199c36ae5f02867a9fc421',
       i686: '014fcfc110e79c9f0c527c74fe30876da5080308c611710fff4d7d630339a7a2',
     x86_64: 'c7beca12335def6dd0f0e25a7d5748236dc04b63adf7a7a5a066bf73ebbdbee8',
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
