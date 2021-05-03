require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://www.eyrie.org/~eagle/software/ansicolor/'
  version '5.01-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/rra/ansicolor/archive/release/5.01.tar.gz'
  source_sha256 'c4865a9fe2ce3a46fd4f11215dcba05a9d5603e797a2623abc19cc14b4a0609a'

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
