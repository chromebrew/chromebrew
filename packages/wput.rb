require 'package'

class Wput < Package
  description 'wput is a command line file upload tool, the opposite of wget'
  homepage 'http://wput.sourceforge.net/'
  version '0.6.2-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/wput/wput/0.6.2/wput-0.6.2.tgz'
  source_sha256 '229d8bb7d045ca1f54d68de23f1bc8016690dc0027a16586712594fbc7fad8c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wput-0.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14f657d436a0d8268ae072b157efcf4270542f44ef859b859c633ba1632e3c20',
     armv7l: '14f657d436a0d8268ae072b157efcf4270542f44ef859b859c633ba1632e3c20',
       i686: '81097c507c097a7de95ceb400240fa676ab399cb177cf95db4f6c982ae1a7f9e',
     x86_64: 'f2b7ed34899a4d0ea18cc553d0028d16683fcebe0915eed11098911aa663c40b',
  })

  depends_on 'gnutls'

  def self.patch
    system "curl -Ls -o config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "install -Dm755 wput #{CREW_DEST_PREFIX}/bin/wput"
    system "install -Dm644 doc/wput.1.gz #{CREW_DEST_PREFIX}/man/man1/wput.1.gz"
  end
end
