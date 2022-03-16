require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_i686/perl_date_format-2.33-1-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_x86_64/perl_date_format-2.33-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'a5fcdf8239f0b75d83a538271c059d06a21500fc6481873b64645edd68081bd6',
  x86_64: '21bac07991851bab2cb245661415a9803c00cdfe690c7a840642df6eebf54275'
  })

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
