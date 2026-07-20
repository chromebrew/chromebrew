require 'buildsystems/perl'

class Perl_try_tiny < PERL
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version "0.31-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a334d98488ed321eb28eea5d224e683f70f275a890e8d43048fd7c017338fe94',
     armv7l: 'a334d98488ed321eb28eea5d224e683f70f275a890e8d43048fd7c017338fe94',
       i686: '19ee98257468fe7153328ca84b6fe2716a66a46aec792e93b3ee48a1b669d4ed',
     x86_64: 'da2e7099c8f0f14d1ff997b0a74073c7ed9bb0cd6ba07a034896d9fb143c2b82'
  })

  depends_on 'perl' => :logical
end
