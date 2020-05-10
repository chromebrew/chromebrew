require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.20'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc/archive/4.8.20.tar.gz'
  source_sha256 'f6d6aebc5ab835f0593b9c30debb39bec05c8073a486aed661e09da3ebe488f9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd0b53981a6e2912f5cc18baf81c6044c51f85e3bf358b20c7b1a5601848c341d',
     armv7l: 'd0b53981a6e2912f5cc18baf81c6044c51f85e3bf358b20c7b1a5601848c341d',
       i686: '4d22ce2993375f766acf5b1dd4e0ffc1001882b57358526f3e23d7647c9cd238',
     x86_64: '8b89fc714399ac3bac0b920c972574471273c7bd4dd3ca46175f18a6e02a6c98',
  })

  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'glib' => :build
  depends_on 'aspell'
  depends_on 'slang'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
