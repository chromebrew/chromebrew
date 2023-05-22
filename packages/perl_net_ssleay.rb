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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_armv7l/perl_net_ssleay-1.92-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_armv7l/perl_net_ssleay-1.92-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_i686/perl_net_ssleay-1.92-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.36_x86_64/perl_net_ssleay-1.92-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '73e4785fea11772bfe6f5b461263c593b866efb6ce1b2bce19dc836cf5fd6ee2',
     armv7l: '73e4785fea11772bfe6f5b461263c593b866efb6ce1b2bce19dc836cf5fd6ee2',
       i686: '265e1e190b232d1c7155ea8d2d727eb9cebb570b002decc11ceff82e79d48fcb',
     x86_64: '7641efe43aa6c31f3ea6416c13671cf5dd891991588d67e27a0ee02812ba38c8'
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
