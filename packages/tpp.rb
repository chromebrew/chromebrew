require 'package'

class Tpp < Package
  description 'tpp stands for text presentation program and is an ncurses-based presentation tool.'
  homepage 'http://www.ngolde.de/tpp.html'
  version '1.3.1'
  compatibility 'all'
  source_url 'http://www.ngolde.de/download/tpp-1.3.1.tar.gz'
  source_sha256 '68e3de94fbfb62bd91a6d635581bcf8671a306fffe615d00294d388ad91e1b5f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tpp-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tpp-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tpp-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tpp-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9c8e83cdd2ed2571e2959b47b33b22f621eb78fd3ef10942c6b30c50a22d823',
     armv7l: 'e9c8e83cdd2ed2571e2959b47b33b22f621eb78fd3ef10942c6b30c50a22d823',
       i686: 'ace7af2826c5f61c639ca903e2c5617f6794ca1f2ae8aa0fc4b8b76f0f780bdd',
     x86_64: '5840c967253bd4eae0e157f7af292d5f10eddc2ca2e8f2fc1fada4d0bb56a14a',
  })

  def self.build
    installed=`gem list | grep ^ncurses-ruby`
    system "gem install ncurses-ruby" unless "#{installed}" != ""
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_DEST_PREFIX},' Makefile"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man1"
    system "make install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man1/tpp.1"
  end
end
