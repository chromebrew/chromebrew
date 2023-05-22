require 'package'

class Perl_net_ssleay < Package
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.92-perl5.36'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.92.tar.gz'
  source_sha256 '47c2f2b300f2e7162d71d699f633dd6a35b0625a00cbda8c50ac01144a9396a9'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_i686/perl_net_ssleay-1.92-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_x86_64/perl_net_ssleay-1.92-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'ac5f4c5f7258acb1d99ae15af602cb446259de5f710ac4b1781be83a4ae51ea8',
  x86_64: 'b20b79a93ff93f258738d83cf16777194d704a1abb27480e4c2bd15b85af9515'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

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
