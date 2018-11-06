require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.2-1'
  source_url 'https://mosh.org/mosh-1.3.2.tar.gz'
  source_sha256 'da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mosh-1.3.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b98ebedc1c978037c92c5451c9d86813ce1a848b43555bfa9543402b76621add',
     armv7l: 'b98ebedc1c978037c92c5451c9d86813ce1a848b43555bfa9543402b76621add',
       i686: '21cb3549ab894dbec38bac38633063193dc5e2f26e264ea72bb4e99b81a54831',
     x86_64: '9b05290bdd93cde4f76b569407f87f4bfe05038bd5f6f323c3f35b6cf1d57e79',
  })

  depends_on 'protobuf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
