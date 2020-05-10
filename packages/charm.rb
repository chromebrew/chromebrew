require 'package'

class Charm < Package
  description 'Charm is a full-featured, cross-platfom blogging client for LiveJournal, Atom (Movable Type, Blogger), and MetaWeb (WordPress).'
  homepage 'http://ljcharm.sourceforge.net/'
  version '1.9.2'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/ljcharm/charm/charm-1.9.2/charm-1.9.2.tar.gz'
  source_sha256 'ae2d536303e770ceb002f69c1e71f6a8532c8d5dd075d2f5c1bf09ad02c3c015'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/charm-1.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/charm-1.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/charm-1.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/charm-1.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b830d2222daab4736c2de2952827371fcf934934640a56606669b163fdd58e5',
     armv7l: '0b830d2222daab4736c2de2952827371fcf934934640a56606669b163fdd58e5',
       i686: 'e7bfeb469261c56e6398019a84c4cf640d16796025420087ac039a6e9a94d119',
     x86_64: '9e826bf34b0c9d7fd6ccb712f57b40e29850c18ffe4d03f39215f66044a9b616',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "python setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "install -Dm644 sample.charmrc #{CREW_DEST_DIR}$HOME/.charmrc"
    system "install -Dm644 sample.charmrc $HOME/.charmrc"
  end

  def self.postinstall
    puts
    puts "To configure, edit $HOME/.charmrc".lightblue
    puts
  end
end
