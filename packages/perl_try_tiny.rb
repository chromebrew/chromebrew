require 'package'

class Perl_try_tiny < Package
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version '0.31-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dad95d43bf05f77e344fe8edd618e4f1b5e5cff9af4b272fc8a8d5c9463630f0',
     armv7l: 'dad95d43bf05f77e344fe8edd618e4f1b5e5cff9af4b272fc8a8d5c9463630f0',
       i686: '39c6954add5451c6b0f2074760091ddb14bf5ffb4027bce20a851b74d048ede1',
     x86_64: 'eae6c6de759e2e24ea63d6052918e4c77c876e246a2a446198e88f539011e0da'
  })

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
