require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.2.3'
  compatibility 'all'
  source_url 'https://github.com/AbiWord/enchant/releases/download/v2.2.3/enchant-2.2.3.tar.gz'
  source_sha256 'abd8e915675cff54c0d4da5029d95c528362266557c61c7149d53fa069b8076d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '92f21186e008957030f456e0880b305c46379be90a66cc7c61c8f2a11160c237',
     armv7l: '92f21186e008957030f456e0880b305c46379be90a66cc7c61c8f2a11160c237',
       i686: '1b0432e9e3cd0d0b9eb29338c46a579f9ad713c25cf9fa25a2adbe91eba24e40',
     x86_64: '80e2b41b7e08a5dcfe61fe5a4d4e3804ffb705f02543777ee413e893205a3b84',
  })

  depends_on 'aspell_en'
  depends_on 'hunspell'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-hunspell',
           '--with-aspell'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
