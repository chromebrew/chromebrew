require 'package'

class Od1n < Package
  description '0d1n is a tool for automating customized attacks against web applications.'
  homepage 'https://github.com/CoolerVoid/0d1n'
  version '2.3'
  compatibility 'all'
  source_url 'https://github.com/CoolerVoid/0d1n/archive/2.3.tar.gz'
  source_sha256 '7fe26f0268fe63ec0352502ae590a7a5e258248f253649661dc782ca7edd52ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/od1n-2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/od1n-2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/od1n-2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/od1n-2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '205e61cefc8dd5655c9621b57701c627b53915af79ec547fdc3ec7796cdaacf5',
     armv7l: '205e61cefc8dd5655c9621b57701c627b53915af79ec547fdc3ec7796cdaacf5',
       i686: '0a2ac8d246e4f6a58a8f836f6c5e1dc66d99161a7c9523a126806b8dc74bdee2',
     x86_64: '38b19eb0cb14694e30040105ac05fd0e250ced2bbac6c0e7428b8adbd495dd2c',
  })

  depends_on 'curl'

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/share/0d1n/payloads",
		       "#{CREW_DEST_PREFIX}/share/0d1n/templates",
		       "#{CREW_DEST_PREFIX}/share/0d1n/response2find",
		       "#{CREW_DEST_PREFIX}/share/0d1n/tables",
                       "#{CREW_DEST_PREFIX}/share/0d1n/doc"]
    FileUtils.cp_r ['doc','payloads','response2find','tables'], "#{CREW_DEST_PREFIX}/share/0d1n/"
    system "install -Dm755 0d1n #{CREW_DEST_PREFIX}/bin/0d1n"
    system "install -m644 *.conf #{CREW_DEST_PREFIX}/share/0d1n"
  end
end
