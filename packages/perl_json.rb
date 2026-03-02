require 'buildsystems/perl'

class Perl_json < PERL
  description 'JSON JavaScript Object Notation encoder/decoder'
  homepage 'https://search.cpan.org/dist/JSON'
  version "4.10-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url "https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-#{version.split('-')[0]}.tar.gz"
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02ab5dcd5e2dd99ce650635c3bb3ed2182a2923787ce24162619cad741c86006',
     armv7l: '02ab5dcd5e2dd99ce650635c3bb3ed2182a2923787ce24162619cad741c86006',
       i686: '6ae5c61335c78767161a3cd9e00785ac4f3b05fdfcc04ac1bee599fd356efb3e',
     x86_64: '2c3d7553b8d36e84a4fcacf8e861935f3b6eb017900e027d43a02a64e31379f5'
  })
end
