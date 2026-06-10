require 'buildsystems/perl'

class Perl_class_inspector < PERL
  description 'Get information about a class and its structure'
  homepage 'https://metacpan.org/pod/Class::Inspector'
  version "1.36-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-#{version.split('-')[0]}.tar.gz"
  source_sha256 'b6af5f4a5e92f1c3d7c9e2a5b9a83c0e2a6f8b9e5d1c3a7b9d2f4e6a8c1d3f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17011315d129023432f8c04a6aeca5ca998afedf5330f59f61ebd93689ca5ce7',
     armv7l: '17011315d129023432f8c04a6aeca5ca998afedf5330f59f61ebd93689ca5ce7',
       i686: 'd2290e61e905805df41781d5fc09516cdb5d8b199a84714be9d2098b08633974',
     x86_64: 'a3f6dca95fa3010da576cc017d9cb4666c468c8d27de5ef5217acbe8204687da'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
