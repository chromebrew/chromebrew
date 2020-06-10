require 'package'

class Faultstat < Package
  description 'Faultstat measures page fault activity and swap utilization of processes'
  homepage 'https://kernel.ubuntu.com/~cking/faultstat/'
  version '0.01.01'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/faultstat/faultstat-0.01.01.tar.xz'
  source_sha256 '81218818fe7498411797289bdd0967e82665d2065407be8b5335eaf2959b8991'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/faultstat-0.01.01-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/faultstat-0.01.01-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/faultstat-0.01.01-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/faultstat-0.01.01-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e77ced9098ba0ceefd750295c6dfa4bd032136d62dd5ca8b80252e9307206c5',
     armv7l: '4e77ced9098ba0ceefd750295c6dfa4bd032136d62dd5ca8b80252e9307206c5',
       i686: 'd06fb76f7101afbdf7faddb3d071462c5636b2f5c14d70361d844d926fc33655',
     x86_64: '6a2eb859919e7ad7e5c6b58541cf04f8c7ab42dd7f03112ddfda6c27198a9053',
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 faultstat #{CREW_DEST_PREFIX}/bin/faultstat"
    system "install -Dm644 faultstat.8 #{CREW_DEST_PREFIX}/share/man/man8/faultstat.8"
  end
end
