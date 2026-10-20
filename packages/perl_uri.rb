require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.40-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-#{version.split('-')[0]}.tar.gz"
  source_sha256 'ef5d2ef099a1a24a6e83ffe543de73337805d3d39c00b84fa205d725ad1a1b63'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffb8404cf71ab849ca9b4f4908133c10e853e9e34efbf660ee05a47ccae1ce03',
     armv7l: 'ffb8404cf71ab849ca9b4f4908133c10e853e9e34efbf660ee05a47ccae1ce03',
       i686: 'fd8acda9a005fb2296a50b5ee9de1939881ec01020cf5c6226b13b96e5421e3d',
     x86_64: '4f7c82adc70a36329187070f6687e06c5a31daf910cd44cf5206127064a043bb'
  })

  depends_on 'perl' => :logical
end
