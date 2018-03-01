require 'package'

class Libopencoreamr < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.5'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz'
  source_sha256 '2c006cb9d5f651bfb5e60156dbff6af3c9d35c7bbcc9015308c0aff1e14cd341'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libopencoreamr-0.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libopencoreamr-0.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libopencoreamr-0.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libopencoreamr-0.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65e1f3039fca63a2ea573a04389b0a291f27ae138e771d66cf029a6c445c76f8',
     armv7l: '65e1f3039fca63a2ea573a04389b0a291f27ae138e771d66cf029a6c445c76f8',
       i686: '5d231320b4a374cd82b901a163142939a68ac146b205e4c381ac8815df8b04b6',
     x86_64: 'ec671e0c663bddca436127a4034172317f4bb97185356f98f285685bf1d700ed',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
