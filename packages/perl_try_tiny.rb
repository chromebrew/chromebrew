require 'package'

class Perl_try_tiny < Package
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version '0.31-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'

  no_compile_needed

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
