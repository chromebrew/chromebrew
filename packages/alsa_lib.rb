require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.4'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version}.tar.gz"
  source_sha256 '0c6ab052d7ea980a01d0208da5e5e10849bd16c4c9961bbd5d2665083b74a6c0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '07cb624cc829dc5f17dcc5d6a9f0a7ea67798bdbc4c27a7a4e075149be91143f',
      armv7l: '07cb624cc829dc5f17dcc5d6a9f0a7ea67798bdbc4c27a7a4e075149be91143f',
        i686: '3baa9db99ab259ba52b8769fd5720da076620a30981133b4143b9e5907698227',
      x86_64: '20132936d9c3ba6fa0126aad6926996f47886ace79548be152cb8aa6975c626d',
  })

  depends_on 'python3'

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS} \
       --with-alsalconfdir=#{CREW_PREFIX}/etc/alsa/conf.d \
       --without-debug \
       --disable-maintainer-mode \
       --with-pythonlibs=-lpython3.9 \
       --with-pythonincludes=-I#{CREW_PREFIX}/include/python3.9"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
