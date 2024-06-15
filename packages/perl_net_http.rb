require 'buildsystems/perl'

class Perl_net_http < PERL
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version '6.23-perl5.40'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.23.tar.gz'
  source_sha256 '0d65c09dd6c8589b2ae1118174d3c1a61703b6ecfc14a3442a8c74af65e0c94e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e47b6ada7fa55b9fdb5548c00bc0e0cc570ddfb27cb7a95bfd4447ea304413ec',
     armv7l: 'e47b6ada7fa55b9fdb5548c00bc0e0cc570ddfb27cb7a95bfd4447ea304413ec',
       i686: '15db41d74e9ab574f869df7a9013f3147754f446cccc83284c38e66eeabc0b28',
     x86_64: '877e7767a502826fceecac942270d19e03fcf786ce7bd6678f6df35368d02855'
  })
end
