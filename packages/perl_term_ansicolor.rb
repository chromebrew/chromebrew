require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://www.eyrie.org/~eagle/software/ansicolor/'
  version '5.01'
  compatibility 'all'
  source_url 'https://github.com/rra/ansicolor/archive/release/5.01.tar.gz'
  source_sha256 'c4865a9fe2ce3a46fd4f11215dcba05a9d5603e797a2623abc19cc14b4a0609a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-5.01-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-5.01-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-5.01-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-5.01-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c96e95727d025667223e7a03bc89fdc061c3d83e4660815a4bf33aa72aafcd09',
     armv7l: 'c96e95727d025667223e7a03bc89fdc061c3d83e4660815a4bf33aa72aafcd09',
       i686: 'bd6ea6dff3b5ceed3f29f495c66473cc943a30d2e6c6a0337f8d0efb16e0b7e4',
     x86_64: '057c9ccc3a3bb84354c4e81383961e9a0d886b3a1e7d3c8a960336da6383b3ba',
  })

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
