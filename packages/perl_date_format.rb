require 'package'

class Perl_date_format < Package
  description 'Date formating subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_format-2.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_format-2.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_format-2.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_format-2.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '74d7cd93d8ab1f1f143be489f57d4379be75524cbf0423a486986d363e64d4ac',
     armv7l: '74d7cd93d8ab1f1f143be489f57d4379be75524cbf0423a486986d363e64d4ac',
       i686: '4833d86c673142afde1cf51e83f852d626c7e0adca756ac4ba0cb565b05984ed',
     x86_64: '4098fabdb8fc6d0ba4011c984a1f1d1b1e7247526e19ee57da9933625d3ccee4',
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
