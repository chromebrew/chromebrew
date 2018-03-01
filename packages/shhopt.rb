require 'package'

class Shhopt < Package
  description 'C-functions for parsing command line options, both traditional one-character options, and GNU\'ish --long-options.'
  homepage 'http://shh.thathost.com/pub-unix/#sshopt'
  version '1.1.7-1'
  source_url 'http://shh.thathost.com/pub-unix/files/shhopt-1.1.7.tar.gz'
  source_sha256 'bae94335124efa6fcc2f0a55cabd68c9c90be935bcdb8054d7e5188e0d5da679'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shhopt-1.1.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shhopt-1.1.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shhopt-1.1.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shhopt-1.1.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd91aea2a6169c7092851f690a289242a0a0bacc0cee6f7f4289aad659d32af0a',
     armv7l: 'd91aea2a6169c7092851f690a289242a0a0bacc0cee6f7f4289aad659d32af0a',
       i686: 'f964a0697bfdfd47a26ab7e771efe22525c7afbc2404208c62d73fb361ab225d',
     x86_64: '5f81978b73c4722a4b5821d7bf865d77eacd94f907f8f3ede2a4b2d366ca9d6a',
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "INSTBASEDIR=#{CREW_DEST_PREFIX}", "install"
  end
end
