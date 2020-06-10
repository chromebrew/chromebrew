require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.9.3'
  compatibility 'all'
  source_url 'https://basic-converter.org/stable/bacon-3.9.3.tar.gz'
  source_sha256 '7f907f4ede68704eefd076733f617438c4baba98e9a1e8676ea1a00c4f8476ae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3688910dbee42cea250706e85b73dc6970aceabb25b855f0d7729ee07421f66',
     armv7l: 'e3688910dbee42cea250706e85b73dc6970aceabb25b855f0d7729ee07421f66',
       i686: 'ed8ac51c3a7f75e27cca79c1fe050f65aa6a188a2b58898961df43a7855d60db',
     x86_64: '4a5ac4797556651820de1081d7be92726d1c01be68f4945f4bc2e78790a1f599',
  })

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui-fltk',
      '--disable-gui-gtk'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
