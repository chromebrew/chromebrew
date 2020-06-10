require 'package'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://www.eyrie.org/~eagle/software/ansicolor/'
  version '4.06'
  compatibility 'all'
  source_url 'https://github.com/rra/ansicolor/archive/release/4.06.tar.gz'
  source_sha256 '0cf6f25ac82ccc0aff2bcfdec23879469626db80f0f50105ec5100236a6830cf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-4.06-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-4.06-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-4.06-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_ansicolor-4.06-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c737c0b923940f726cbbfe7621a80fc3210f4f6b54829d74f992729bbd4551bb',
     armv7l: 'c737c0b923940f726cbbfe7621a80fc3210f4f6b54829d74f992729bbd4551bb',
       i686: '54381d835ba791f21964f94e3bd06772b18a6a2b467b909d752971ac54246eb1',
     x86_64: '87c9ab464473d6d6b155bb28a40ed5738b7485452e85fe9bf2c8e86e17a27635',
  })

  def self.build
    system "perl", "Makefile.PL"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
