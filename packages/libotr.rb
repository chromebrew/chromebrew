require 'package'

class Libotr < Package
  description 'Portable OTR Messaging Library, as well as the toolkit to help you forge messages.'
  homepage 'https://otr.im/'
  version '4.1.1'
  compatibility 'all'
  source_url 'https://otr.im/dist/libotr/4.1.1/libotr-4.1.1.tar.gz'
  source_sha256 '8b3b182424251067a952fb4e6c7b95a21e644fbb27fbd5f8af2b2ed87ca419f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libotr-4.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libotr-4.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libotr-4.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libotr-4.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a5eaefb2acefa8d32f235346c96d617aee71f0168d017077d634af43516b6f76',
     armv7l: 'a5eaefb2acefa8d32f235346c96d617aee71f0168d017077d634af43516b6f76',
       i686: '874c32fe8ec8129a982fc5e60a69b7ef38845de8fb47a1b45f844d9a20189973',
     x86_64: 'ada7656b406b95ba63d3150e1a46323946ddb1ee0b497a7d7298ee4fb36f7956',
  })

  depends_on 'libgcrypt'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
