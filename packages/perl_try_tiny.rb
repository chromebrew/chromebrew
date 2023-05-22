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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_i686/perl_try_tiny-0.31-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_try_tiny/0.31-perl5.36_x86_64/perl_try_tiny-0.31-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '4d79e29bb819be4dbbd6c42f4a674930b5be8b2e136816ca01066ad24729e494',
  x86_64: '93a55697c63030fe5fa0e6144ebeba778e421b201abd9682c863d9a919c887ba'
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
