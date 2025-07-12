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
    aarch64: '987954e5917fde35d7917f160a8890df5e403563f67ed017a56d18b06bf1067e',
     armv7l: '987954e5917fde35d7917f160a8890df5e403563f67ed017a56d18b06bf1067e',
       i686: 'dffd0b7217d81587baf7896551156029582928bc8b1d8517dc43fab408147b1b',
     x86_64: 'b2787c35a09cedf3d9ab2d483ece66f3f7b0fae7b179f1f6be7707d264dbaa43'
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
