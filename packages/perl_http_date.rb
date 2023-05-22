require 'package'

class Perl_http_date < Package
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version '6.05-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.05.tar.gz'
  source_sha256 '365d6294dfbd37ebc51def8b65b81eb79b3934ecbc95a2ec2d4d827efe6a922b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_date/6.05-perl5.36_armv7l/perl_http_date-6.05-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_date/6.05-perl5.36_armv7l/perl_http_date-6.05-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_date/6.05-perl5.36_i686/perl_http_date-6.05-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_date/6.05-perl5.36_x86_64/perl_http_date-6.05-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22dafdcfe453bdb7109f4188ec83c3b73266d333e74800e34eebf48dad05c56f',
     armv7l: '22dafdcfe453bdb7109f4188ec83c3b73266d333e74800e34eebf48dad05c56f',
       i686: '9cb09ca39ccfbddc5079e91d799d2eaea1c077b5f1cc2f4cd01e6646ab6fd92e',
     x86_64: 'c9f5a47853a8c73a5031545b2f0bd3aad9b2d1f20937fb7250e6af72c2f1cf1d'
  })

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
