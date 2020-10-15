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
    aarch64: 'e12636b27086aab2d0726826041b3b2765b6b5e6f83de7b65e8da61164faeff7',
     armv7l: 'e12636b27086aab2d0726826041b3b2765b6b5e6f83de7b65e8da61164faeff7',
       i686: 'ea76e2d8a143358d2813861b9cd89a5e80078d172310b321bd3a05f6af36094e',
     x86_64: '3af38627d41d1e3536fa9d7c3db4e0d4a6573a579ee1eac9af10384ac19a1d95',
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
