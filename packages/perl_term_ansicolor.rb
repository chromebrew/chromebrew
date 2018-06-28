require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://www.eyrie.org/~eagle/software/ansicolor/'
  version '4.06'
  source_url 'https://github.com/rra/ansicolor/archive/release/4.06.tar.gz'
  source_sha256 '0cf6f25ac82ccc0aff2bcfdec23879469626db80f0f50105ec5100236a6830cf'

  def self.build
    system "perl", "Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
