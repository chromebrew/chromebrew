require 'package'

class Tpp < Package
  description 'tpp stands for text presentation program and is an ncurses-based presentation tool.'
  homepage 'http://www.ngolde.de/tpp.html'
  version '1.3.1'
  source_url 'http://www.ngolde.de/download/tpp-1.3.1.tar.gz'
  source_sha256 '68e3de94fbfb62bd91a6d635581bcf8671a306fffe615d00294d388ad91e1b5f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

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
