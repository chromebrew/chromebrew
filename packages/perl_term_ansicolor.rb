require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://www.eyrie.org/~eagle/software/ansicolor/'
  version '5.01-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/rra/ansicolor/archive/release/5.01.tar.gz'
  source_sha256 'c4865a9fe2ce3a46fd4f11215dcba05a9d5603e797a2623abc19cc14b4a0609a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_ansicolor/5.01-1_armv7l/perl_term_ansicolor-5.01-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_ansicolor/5.01-1_armv7l/perl_term_ansicolor-5.01-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_ansicolor/5.01-1_i686/perl_term_ansicolor-5.01-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_ansicolor/5.01-1_x86_64/perl_term_ansicolor-5.01-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3007f881b95506691c56c97be273587e1155dd520ffcf680624628de15cf3abf',
     armv7l: '3007f881b95506691c56c97be273587e1155dd520ffcf680624628de15cf3abf',
       i686: 'ea4224102ff52f47853d1bafdd80a77eb49680f86138f7733dcf9ae918e7e677',
     x86_64: '736e5f517bcefe676c75ebe6f251972119b6593b7be2acc6dc7504f1edc819ef'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
