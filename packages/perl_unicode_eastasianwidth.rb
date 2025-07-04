require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version "12.0-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5047e3abe1285ee8a254babe91b63fb2d160f1cd216a1ae9bf8f90cbeb46c91',
     armv7l: 'b5047e3abe1285ee8a254babe91b63fb2d160f1cd216a1ae9bf8f90cbeb46c91',
       i686: '4e7980ab1f1b5ea0238501f66f430a2d06621aa71627877612d9b129f75b7c37',
     x86_64: '125ab8a840e3398b19304d286d15b9a75e3c4a23262210d80ad0120c879a94ff'
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
