require 'package'

class Profanity < Package
  description 'A console based XMPP client'
  homepage 'https://profanity-im.github.io/'
  version '0.6.0'
  compatibility 'all'
  source_url 'https://profanity-im.github.io/profanity-0.6.0.tar.gz'
  source_sha256 'f1b2773b79eb294297686f3913e9489c20effae5e3a335c8956db18f6ee2f660'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/profanity-0.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/profanity-0.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/profanity-0.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/profanity-0.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '59229f908a8f21765e77aaa1a491ae23155452f013e9cc992f365bd66293f795',
     armv7l: '59229f908a8f21765e77aaa1a491ae23155452f013e9cc992f365bd66293f795',
       i686: '3d5c96c99a811d0a86b89ab88bb42fb5d277fc97a8f29a54b8985172ec7736ff',
     x86_64: 'ead2d0a06e37c622913b76941c292a3b10ad500a1f75ebab45e2b08779f007bd',
  })

  depends_on 'curl'
  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'gtk2'
  depends_on 'libotr'
  depends_on 'libnotify'
  depends_on 'libstrophe'

  def self.build
   system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
   system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
