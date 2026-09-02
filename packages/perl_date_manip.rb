require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version "7.00-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-#{version.split('-')[0]}.tar.gz"
  source_sha256 '37133eeb09d36da6d461546cc216b8f6a2297a43331c680a6848f3fff925975c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '392abe47099efd04492edcab40d77a2be2ae3e584fd06076db385c4006006662',
     armv7l: '392abe47099efd04492edcab40d77a2be2ae3e584fd06076db385c4006006662',
       i686: 'ee89707d71592845f011d2ba3ed44f700d027c823ba971a62f6042257f4a8abc',
     x86_64: '8c6ebc923fe51b18bf33b95ff0505f78776986c4af930f5e650ef9a4ce3f7905'
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
