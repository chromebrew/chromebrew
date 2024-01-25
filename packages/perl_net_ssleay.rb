require 'buildsystems/perl'

class Perl_net_ssleay < PERL
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.92-perl5.38.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.92.tar.gz'
  source_sha256 '47c2f2b300f2e7162d71d699f633dd6a35b0625a00cbda8c50ac01144a9396a9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '776241c06513b5c61d4515d13fbf31ea73adc596b1c16b64fbed4eb1c81b9646',
     armv7l: '776241c06513b5c61d4515d13fbf31ea73adc596b1c16b64fbed4eb1c81b9646',
       i686: 'f0e041b555d744fe07ccb38b167fe32823ad55491b04fbed2da29a4b532fd5ef',
     x86_64: 'ba8b2747986a88755672d7e99aad3c0fa4efe567a0d89762bda3e65e37d781b4'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R
end
