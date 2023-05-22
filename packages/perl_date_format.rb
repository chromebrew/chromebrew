require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.36_armv7l/perl_date_format-2.33-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.36_armv7l/perl_date_format-2.33-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.36_i686/perl_date_format-2.33-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.36_x86_64/perl_date_format-2.33-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7625e4a9b268e9a386ef6aef3c15cd6859ab64aa4f44f224fe1f379ffafe4fd8',
     armv7l: '7625e4a9b268e9a386ef6aef3c15cd6859ab64aa4f44f224fe1f379ffafe4fd8',
       i686: '49572fc06e005d477fe9d7aa4cae9857c32ef368d3cafc1cd5f71cd457ba8c64',
     x86_64: '76da7d520862d013ed891d9ab7509e6f1ee073cd09795c64f4829dfc9d2d449d'
  })

  conflicts_ok #  conflicts with perl_xml_parser

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Conflict with perl_xml_parser package.
    # FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.32.1/Date/Language/Amharic.pm"
  end
end
