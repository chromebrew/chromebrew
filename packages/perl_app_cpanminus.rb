require 'package'

class Perl_app_cpanminus < Package
  description 'App::cpanminus - get, unpack, build and install modules from CPAN'
  homepage 'https://metacpan.org/pod/App::cpanminus'
  version '1.7046-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7046.tar.gz'
  source_sha256 '3e8c9d9b44a7348f9acc917163dbfc15bd5ea72501492cea3a35b346440ff862'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2aeff3bc9c343b4d8f8fb6c20ee2fd010a3146b6dde47d4536e29a80325263d8',
     armv7l: '2aeff3bc9c343b4d8f8fb6c20ee2fd010a3146b6dde47d4536e29a80325263d8',
       i686: '8a773ad82602c32c7c0200e9bf5e8f29e494e4eedd11d3e8c2df024a593a784a',
     x86_64: '057a9d52793e4072da7bbb86519df37b0060bcbfe46a015d9eed80503008a810'
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
