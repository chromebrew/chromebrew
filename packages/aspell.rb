require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.7-rc1-2'
  source_url 'ftp://alpha.gnu.org/gnu/aspell/aspell-0.60.7-rc1.tar.gz'
  source_sha256 '86b5662f24316142f70c5890787bdc5596625ca3604dfe85926ee61f27f2365e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ca034e3223929f915c21d78bb79362d24aed843d4a57128c77a3d1fb98f095fd',
     armv7l: 'ca034e3223929f915c21d78bb79362d24aed843d4a57128c77a3d1fb98f095fd',
       i686: 'bae1a0dddf70e94915b274f982227f1b166860db2337dc34abe87e0992377075',
     x86_64: 'b2091d31a112bda77f2692a686f48760b647521b277391cd6d5f56f783a03f5f',
  })

  depends_on 'ruby' unless File.exists? '/usr/local/bin/ruby'
  depends_on 'ncursesw'

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
