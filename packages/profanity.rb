require 'package'

class Profanity < Package
  description 'A console based XMPP client'
  homepage 'https://profanity-im.github.io/'
  version '0.6.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://profanity-im.github.io/profanity-0.6.0.tar.gz'
  source_sha256 'f1b2773b79eb294297686f3913e9489c20effae5e3a335c8956db18f6ee2f660'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '59229f908a8f21765e77aaa1a491ae23155452f013e9cc992f365bd66293f795',
     armv7l: '59229f908a8f21765e77aaa1a491ae23155452f013e9cc992f365bd66293f795',
     x86_64: 'ead2d0a06e37c622913b76941c292a3b10ad500a1f75ebab45e2b08779f007bd'
  })

  depends_on 'curl'
  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'gtk2'
  depends_on 'libotr'
  depends_on 'libnotify'
  depends_on 'libstrophe'

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
