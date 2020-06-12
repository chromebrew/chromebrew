require 'package'

class Help2info < Package
  description 'help2info is a bash script that generates a simple info page from the output of the --help argument of the specified program.'
  homepage 'http://savannah.nongnu.org/projects/help2info'
  version '0.1.1'
  compatibility 'all'
  source_url 'http://download.savannah.nongnu.org/releases/help2info/help2info-0.1.1.tar.bz2'
  source_sha256 '9964fa462fb3e0f0646c97d986b69b3365461e94365cd80c5ec57f03ca08a839'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/help2info-0.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/help2info-0.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/help2info-0.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/help2info-0.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0d160d979279945e7c48f383a3caad240857432bc289f1e419d72ca210db4fe',
     armv7l: 'f0d160d979279945e7c48f383a3caad240857432bc289f1e419d72ca210db4fe',
       i686: '82cafd759e044aa98a96f712d7797ed3ce8c215fd45b2e996e2cb60e69dc3c90',
     x86_64: '792983412f4b466c4a3c8f98cc16442701f2a7a26c6063e8335589dde5d0970a',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
