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

  binary_sha256({
    aarch64: '164bb060096d6e83c9eda3da9c847cce65fe7940708f19ccc1cdd5a7393934b2',
     armv7l: '164bb060096d6e83c9eda3da9c847cce65fe7940708f19ccc1cdd5a7393934b2',
       i686: '7823bb0d905f6839848903257606892a9fb3400f705121527554bb197200ce19',
     x86_64: 'b79a4d0a655d2a384be4beccc3979f6ec509b4833e44fc3c4535433be89713d5'
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
