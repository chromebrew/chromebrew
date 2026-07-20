require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version "6.99-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-#{version.split('-')[0]}.tar.gz"
  source_sha256 '92383832311f22083f55d03c8dae8f4bcc387cd902624e5ef9ac680f144cbd4c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42eed6abc21985269b9192f765a6ca7f2d82a887bc14bb74f44e56e338faa3b5',
     armv7l: '42eed6abc21985269b9192f765a6ca7f2d82a887bc14bb74f44e56e338faa3b5',
       i686: '18f26def7c8763899ffc76b1088b4fca64f916617ccd3a63ab9c0c9ce221b92a',
     x86_64: '2030193c0e5e5d5148a75f5d9af0472014bb35675c27208bae5e0603fc494a04'
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
  end
end
