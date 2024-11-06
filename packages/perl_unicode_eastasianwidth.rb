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
    aarch64: 'f1603d9ec54f0360c78df76f7188b431467b2fe800be97f01c32ecca860a87f8',
     armv7l: 'f1603d9ec54f0360c78df76f7188b431467b2fe800be97f01c32ecca860a87f8',
       i686: 'ee94f24739538c1b0b50c25bff3aec171c51077d40750f1f178812b5564e75b1',
     x86_64: '1d45396a77ad9abb31b63e23f1b012c3dafadaca944b454c642760a18a200d24'
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
