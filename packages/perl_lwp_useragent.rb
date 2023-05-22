require 'package'

class Perl_lwp_useragent < Package
  description 'Web user agent class'
  homepage 'https://metacpan.org/pod/LWP::UserAgent'
  version '6.70-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/libwww-perl-6.70.tar.gz'
  source_sha256 '34f00d2344757b9c0b55ad35808d53e93d7d92f7a464ec837fe6a73c51fb5969'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.36_armv7l/perl_lwp_useragent-6.70-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.36_armv7l/perl_lwp_useragent-6.70-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.36_i686/perl_lwp_useragent-6.70-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_useragent/6.70-perl5.36_x86_64/perl_lwp_useragent-6.70-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c66efed60d462ef0a0d866759999823e49ed09403e0ba9f7d0de17405eac838',
     armv7l: '4c66efed60d462ef0a0d866759999823e49ed09403e0ba9f7d0de17405eac838',
       i686: '813fb23f85cdf25ce27eedb04118171e81b3e6188ada4c6d11a4ec7ca017239b',
     x86_64: '417837c84a47999a7df13f82bfd7ecbc14458fd4fcda64cd4068a74df2f99ae0'
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
