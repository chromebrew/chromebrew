require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Avoid conflicts with other perl module installs
    system "find #{CREW_DEST_DIR} -name .packlist -o -name perllocal.pod -delete"
    # Conflict with perl_xml_parser package.
    FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.32.1/Date/Language/Amharic.pm"
  end
end
