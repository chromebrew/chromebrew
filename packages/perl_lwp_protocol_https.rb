require 'buildsystems/perl'

class Perl_lwp_protocol_https < PERL
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version '6.14-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.14.tar.gz'
  source_sha256 '59cdeabf26950d4f1bef70f096b0d77c5b1c5a7b5ad1b66d71b681ba279cbb2a'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'd90c117d9d7623f9f5dbbd771b1811c4678ff48d2a05c98638120bb569aa10dc',
    aarch64: '2b4ce7726cdf52eb3e1b41a0dbfcf5ba4ae9fdd7e1b2f0c012d70b37fe103e70',
     armv7l: '2b4ce7726cdf52eb3e1b41a0dbfcf5ba4ae9fdd7e1b2f0c012d70b37fe103e70',
     x86_64: 'bfa9383ea6cd33ec7903b8197999c08ac192a54b15dfc77fed8f2b5007d8542e'
  })
end
