require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version '1.66-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.66.tar.gz'
  source_sha256 '22928a7bffe61b452c05bbbb8f5216d4b9cf9fe2a849b776c25500d24d20df7c'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_i686/perl_pod_parser-1.66-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_x86_64/perl_pod_parser-1.66-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '108f3307be1420cff1cdf67076586a55655cf41365ec993035bcd7775b14494e',
  x86_64: '032d57d2721c4066c5c4e8dbae5902d0f1d713fb1876815dbe657fcf6f0ff6da'
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
