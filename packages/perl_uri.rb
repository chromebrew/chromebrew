require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.19-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/URI-5.19.tar.gz'
  source_sha256 '8fed5f819905c8a8e18f4447034322d042c3536b43c13ac1f09ba92e1a50a394'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0e48971e192df1733a15d303da4310da37f646cb53fa1fd664a9ea10d434050',
     armv7l: 'e0e48971e192df1733a15d303da4310da37f646cb53fa1fd664a9ea10d434050',
       i686: 'cfad43e5a84e61e1c02fdff1b5e7daf9e03d989b2b60c0097d1d60ff1fe28eb3',
     x86_64: 'fa9d5e077a186227c4b3716cecb24dbf078700e199f6bab0f21845def27c4e2a'
  })

  depends_on 'perl' => :logical
end
