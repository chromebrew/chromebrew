require 'package'

class Banner < Package
  description 'An implementation of the traditional Unix-program used to display large characters.'
  homepage 'http://shh.thathost.com/pub-unix/#banner'
  version '1.3.2'
  compatibility 'all'
  source_url 'http://shh.thathost.com/pub-unix/files/banner-1.3.2.tar.gz'
  source_sha256 '0dc0ac0667b2e884a7f5ad3e467af68cd0fd5917f8c9aa19188e6452aa1fc6d5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/banner-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/banner-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/banner-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/banner-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f92922550b0c8f695e68f66373ce70a874d2cfde353cf1718ef78e5ecbb364ef',
     armv7l: 'f92922550b0c8f695e68f66373ce70a874d2cfde353cf1718ef78e5ecbb364ef',
       i686: '6e3e4d1f74402045c7d1dc2e8ef5696ce67d06155fbd156bb548ba9f7eaf4bdf',
     x86_64: 'a7491d42ecb79b479b9bc49ff45860e5bcf50c2b763e6524c711ec90d5829c31',
  })

  depends_on 'shhmsg'
  depends_on 'shhopt'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "INSTBASEDIR=#{CREW_DEST_PREFIX}", 'install'
  end
end
