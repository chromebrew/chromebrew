require 'package'

class Perl_app_cpanminus < Package
  description 'App::cpanminus - get, unpack, build and install modules from CPAN'
  homepage 'https://metacpan.org/pod/App::cpanminus'
  version '1.7046-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7046.tar.gz'
  source_sha256 '3e8c9d9b44a7348f9acc917163dbfc15bd5ea72501492cea3a35b346440ff862'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7045_armv7l/perl_app_cpanminus-1.7045-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7045_armv7l/perl_app_cpanminus-1.7045-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7045_i686/perl_app_cpanminus-1.7045-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7045_x86_64/perl_app_cpanminus-1.7045-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '688d1f8c904ef638932f871b8364492ae6d487e0ce1b0a3357eec9749555dc66',
     armv7l: '688d1f8c904ef638932f871b8364492ae6d487e0ce1b0a3357eec9749555dc66',
       i686: 'c4242cf166543fc1bca251e32346c00f6c2035f8e4108a010dc8485e2e6de461',
     x86_64: 'f6448d53166638b53d376d4cd5358acfd65de7da839313d81234618abf56347e'
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
