require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.2-1'
  source_url 'https://ftpmirror.gnu.org/datamash/datamash-1.2.tar.gz'
  source_sha256 'e8d46fb22ccc77e5380f26cde622a733f363d388b04a2c22e7fb6de0e9d85996'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40ec18f558c13685dbac540f2f5f818dbc87b98099579df1b53babbf9d020776',
     armv7l: '40ec18f558c13685dbac540f2f5f818dbc87b98099579df1b53babbf9d020776',
       i686: '4a928497012b69d437fa3f3be3614d33c903663a7eb800d8e73c202d3a7f026c',
     x86_64: '54822159bf3a4156f5119eb1da84878d32f253317dda213f8291677a6dccf499',
  })

  depends_on 'compressdoc' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
