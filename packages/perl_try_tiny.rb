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
       i686: '35b2879a17e32dd7d4168015310ba4dcc4c36db6b1eaa3828e7bc3ed4b9cf165',
    aarch64: '37b1f32730570d4bd04c52f38055e75db384d7ef5e73af8b8bcc6324cdcf8ef0',
     armv7l: '37b1f32730570d4bd04c52f38055e75db384d7ef5e73af8b8bcc6324cdcf8ef0',
     x86_64: 'e920584bd8a68a5547936e314c14839908ad20ec0bdc78c5e8e2e168c8142adb'
  })
end
