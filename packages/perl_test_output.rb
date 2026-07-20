require 'package'

class Perl_test_output < Package
  description 'Test::Output - Utilities to test STDOUT and STDERR messages.'
  homepage 'https://metacpan.org/pod/Test::Output'
  version "1.036-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/B/BR/BRIANDFOY/Test-Output-#{version.split('-')[0]}.tar.gz"
  source_sha256 'a3a95cb8c4d387fe079add4490757e69927ef0488bbb18b4d55e7fc6d25f1a63'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f9c2d6b2fd47e1f0e62d102189acd76026f3cd3362660d906a6657c7cdeaf5b',
     armv7l: '8f9c2d6b2fd47e1f0e62d102189acd76026f3cd3362660d906a6657c7cdeaf5b',
       i686: 'bd3ee95f7a609a3deb76ae647203f961e8581c0e4656a19eb0f4b21f70536e4e',
     x86_64: '28fc990fc0f8719c492e8921230724d0f5d45d7d62ea20c542793a7f26fbbf68'
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
