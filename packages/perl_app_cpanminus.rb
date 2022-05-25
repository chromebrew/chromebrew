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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.38_armv7l/perl_app_cpanminus-1.7046-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.38_armv7l/perl_app_cpanminus-1.7046-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.38_i686/perl_app_cpanminus-1.7046-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.38_x86_64/perl_app_cpanminus-1.7046-perl5.38-chromeos-x86_64.tar.zst'
  })
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
