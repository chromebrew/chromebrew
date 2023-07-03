require 'package'

class Perl_net_ssleay < Package
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.92-perl5.38'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.92.tar.gz'
  source_sha256 '47c2f2b300f2e7162d71d699f633dd6a35b0625a00cbda8c50ac01144a9396a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38_armv7l/perl_net_ssleay-1.92-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38_armv7l/perl_net_ssleay-1.92-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38_i686/perl_net_ssleay-1.92-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38_x86_64/perl_net_ssleay-1.92-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c91931945668c1d5aa628828851b31b8179211d3b2bbc52c934d8362fded337e',
     armv7l: 'c91931945668c1d5aa628828851b31b8179211d3b2bbc52c934d8362fded337e',
       i686: 'fbc0ea95d57e97bd4652d4ca64281f33f6b608b6845becbb092402bac0ca8414',
     x86_64: '8f672b3fa6f9c612ebe94b9a326de37cbbd7c6fbdda9a4272c730498c205e80a'
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
