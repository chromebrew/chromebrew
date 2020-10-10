require 'package'

class Perl_read_key < Package
  description 'Character mode terminal access for Perl Term::ReadKey'
  homepage 'https://metacpan.org/source/JSTOWE/TermReadKey-2.37/'
  version '2.38'
  compatibility 'all'
  source_url 'https://github.com/jonathanstowe/TermReadKey/archive/2.38.tar.gz'
  source_sha256 'bb669c422d7094e19fa85d43676b67933b86d4a1f6b39fed5dbfaaaa97716c1d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.38-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.38-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.38-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_read_key-2.38-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2c32777a39c44accb5bf5ee9b9155cc186faf148a4cc89218c50fe9ca38a7fdf',
     armv7l: '2c32777a39c44accb5bf5ee9b9155cc186faf148a4cc89218c50fe9ca38a7fdf',
       i686: '8cf68da938a505a90e84d442e196f0eaa58802568cb42b1ffb087265ec79f251',
     x86_64: 'e06db1036175a0277adc945b09d213dd3f18f4978399e6aa27c9d79b3aa18360',
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
