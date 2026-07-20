require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version "6.95-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.95.tar.gz'
  source_sha256 '92383832311f22083f55d03c8dae8f4bcc387cd902624e5ef9ac680f144cbd4c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4003bcbe84a808d89e55409e5e35c2bf87530414a7a182dff95b67e91564fcfc',
     armv7l: '4003bcbe84a808d89e55409e5e35c2bf87530414a7a182dff95b67e91564fcfc',
       i686: 'e194cec65c91e34950e68d8a26be96da9bfb2bfc7755ea87a122fcf7d7b04a10',
     x86_64: 'a15d6e68535be500ae622adbd104091203556ee262ddce8c4d175527ee520b99'
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
