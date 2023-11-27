require 'buildsystems/perl'

class Perl_net_ssleay < PErl
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.92-perl5.38.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.92.tar.gz'
  source_sha256 '47c2f2b300f2e7162d71d699f633dd6a35b0625a00cbda8c50ac01144a9396a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38.1_armv7l/perl_net_ssleay-1.92-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38.1_armv7l/perl_net_ssleay-1.92-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38.1_i686/perl_net_ssleay-1.92-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.92-perl5.38.1_x86_64/perl_net_ssleay-1.92-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f6f038c94dd24a4e6a697427555018857b44bb1a277c3f83340db631e154c370',
     armv7l: 'f6f038c94dd24a4e6a697427555018857b44bb1a277c3f83340db631e154c370',
       i686: '51594ba90b3524dd0e1f70e78e13ed621547ded18ffa3f8fc9fa302b293e61cf',
     x86_64: '6ad8d74152f699fd03dab5303f4307377817a560c24460c3cb59eab16c1ea244'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R
end
