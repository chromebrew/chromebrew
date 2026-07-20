require 'buildsystems/perl'

class Perl_text_csv < PERL
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version "2.06-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-#{version.split('-')[0]}.tar.gz"
  source_sha256 'dfcaec925a788b0ba41e51bc6d16e21b0e98b4c7af9b79395090add75f5e506f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f3f1d8cf027a95750f4880ac180afacfaa3589750bb763e5efe3bf994839190',
     armv7l: '5f3f1d8cf027a95750f4880ac180afacfaa3589750bb763e5efe3bf994839190',
       i686: '05be43b9113d71ed889fc213f4a923a89d8a2ac2b1324c4b26987d4495541864',
     x86_64: '902ef71c3aaf1a760b9814d1b627da5f073e0b205a631fa02f8055e58faf8d8c'
  })

  depends_on 'perl' => :logical
end
