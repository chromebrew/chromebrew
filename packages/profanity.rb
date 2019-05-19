require 'package'

class Profanity < Package
  description 'A console based XMPP client'
  homepage 'https://profanity-im.github.io/'
  version '0.6.0'
  source_url 'https://profanity-im.github.io/profanity-0.6.0.tar.gz'
  source_sha256 'f1b2773b79eb294297686f3913e9489c20effae5e3a335c8956db18f6ee2f660'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'curl'
  depends_on 'glib'
  depends_on 'libstrophe'

  def self.build
   system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
   system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
