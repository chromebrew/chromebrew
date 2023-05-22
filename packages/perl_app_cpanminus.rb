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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.36_armv7l/perl_app_cpanminus-1.7046-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.36_armv7l/perl_app_cpanminus-1.7046-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.36_i686/perl_app_cpanminus-1.7046-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_app_cpanminus/1.7046-perl5.36_x86_64/perl_app_cpanminus-1.7046-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ab34b9201aa1afbe9c3780559be9a45fc1c5e790024556b057a153c227854b0c',
     armv7l: 'ab34b9201aa1afbe9c3780559be9a45fc1c5e790024556b057a153c227854b0c',
       i686: '1270c228ef305d754a8a7bf91aa48a4a4fb0ebc497bba616a9f71c30582d59cc',
     x86_64: '701d2656d770acff0e83b6a4067700c9ebbfa44052ff15f7a74f8ffab7b6f448'
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
