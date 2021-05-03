require 'package'

class Perl_date_manip < Package
  description 'Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.82-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.82.tar.gz'
  source_sha256 'fa96bcf94c6b4b7d3333f073f5d0faad59f546e5aec13ac01718f2e6ef14672a'

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Avoid conflicts with other perl module installs
    system "find #{CREW_DEST_DIR} -name .packlist -o -name perllocal.pod -delete"
  end
end
