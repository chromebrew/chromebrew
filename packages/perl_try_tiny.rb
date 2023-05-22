require 'package'

class Perl_try_tiny < Package
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version '0.31-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_armv7l/perl_try_tiny-0.31-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_armv7l/perl_try_tiny-0.31-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_i686/perl_try_tiny-0.31-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_x86_64/perl_try_tiny-0.31-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf9e24108b49411ea3def3f53b42083f18d463f0e30830876ceedce444aafa6e',
     armv7l: 'bf9e24108b49411ea3def3f53b42083f18d463f0e30830876ceedce444aafa6e',
       i686: '99aef16ec89e3f54296131e55716220340f2a6433ce00f240fd6757aae3a7610',
     x86_64: 'a435e9930ca53b79255d58df24b322e662538fb11495110bddf37d632a3acc0a'
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
