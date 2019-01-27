require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.8'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.8.tar.bz2'
  source_sha256 '3cdc3a93a6427a26d8efab4ada2152e64dd89140d981f6ffa003e85be707aedf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd94c01b609084242a81ba4c2427434cbc1a6ae47964906f153226b14ec23e2fb',
     armv7l: 'd94c01b609084242a81ba4c2427434cbc1a6ae47964906f153226b14ec23e2fb',
       i686: '2ed364d08fd327fc73d9d885fc0612c9e15c6af0de3864f6aab8e2b640b9a851',
     x86_64: '8fbcdb011920f27fabec31ef9e2057ccbdb26ae14ba3ac468a83c6ca767bf7cc',
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
