require 'package'

class Perl_read_key < Package
  description 'Character mode terminal access for Perl Term::ReadKey'
  homepage 'https://metacpan.org/source/JSTOWE/TermReadKey-2.37/'
  version '2.38-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/jonathanstowe/TermReadKey/archive/2.38.tar.gz'
  source_sha256 'bb669c422d7094e19fa85d43676b67933b86d4a1f6b39fed5dbfaaaa97716c1d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_read_key/2.38-1_armv7l/perl_read_key-2.38-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_read_key/2.38-1_armv7l/perl_read_key-2.38-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_read_key/2.38-1_i686/perl_read_key-2.38-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_read_key/2.38-1_x86_64/perl_read_key-2.38-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '76f4f39f14ad060edeca2bcf605985be09aa03296dcf3b4883bdebfa6984c2e6',
     armv7l: '76f4f39f14ad060edeca2bcf605985be09aa03296dcf3b4883bdebfa6984c2e6',
       i686: '896d0bcd908ab549c756b065b9edb0f4c6fe1977dd2719c63929f4756d49a543',
     x86_64: 'a7694ccb4d399c07c92027268d5548223ad54c1234ae2a9248d8eaa9e73851b6'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
