require 'package'

class Perl_try_tiny < Package
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version '0.31-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.38_armv7l/perl_try_tiny-0.31-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.38_armv7l/perl_try_tiny-0.31-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.38_i686/perl_try_tiny-0.31-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.38_x86_64/perl_try_tiny-0.31-perl5.38-chromeos-x86_64.tar.zst'
  })
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
