require 'package'

class Perl_lwp_useragent < Package
  description 'Web user agent class'
  homepage 'https://metacpan.org/pod/LWP::UserAgent'
  version '6.70-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/libwww-perl-6.70.tar.gz'
  source_sha256 '34f00d2344757b9c0b55ad35808d53e93d7d92f7a464ec837fe6a73c51fb5969'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.38_armv7l/perl_lwp_useragent-6.70-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.38_armv7l/perl_lwp_useragent-6.70-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.38_i686/perl_lwp_useragent-6.70-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.38_x86_64/perl_lwp_useragent-6.70-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '57e1b69386760c070f0163161dc6218eba21a209ab39b3877d2198e3c29d595a',
     armv7l: '57e1b69386760c070f0163161dc6218eba21a209ab39b3877d2198e3c29d595a',
       i686: '55e2f3f52bbd90e104f93d7bcad5e77cf168a972a8cdef5233b00947416dc927',
     x86_64: '514405dd0e89c6953fc5edd389e4d314f733b943e175122efe645341947defe2'
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
