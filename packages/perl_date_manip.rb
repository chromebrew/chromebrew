require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.95-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.95.tar.gz'
  source_sha256 '92383832311f22083f55d03c8dae8f4bcc387cd902624e5ef9ac680f144cbd4c'
  binary_compression 'tar.zst'

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
