require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.35-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-#{version.split('-')[0]}.tar.gz"
  source_sha256 '89648964ce5ae006726951f42f718576fbefe9e98a41bd2212d57386163092d2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c8f331361d76f146a2fb5a574ed4622bdbce9c6a1626c4664949f74d08cccb3',
     armv7l: '9c8f331361d76f146a2fb5a574ed4622bdbce9c6a1626c4664949f74d08cccb3',
       i686: 'ad879ac8dc54ed827d313cdff962150005b31432e40e84bb701b8a44b8d71b3f',
     x86_64: '0e33b3315e4f6155d8482d5ef0603cef7dc32dd9983569457346f0fdcb911944'
  })

  depends_on 'perl' => :logical
end
