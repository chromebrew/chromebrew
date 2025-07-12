require 'buildsystems/perl'

class Perl_text_csv < PERL
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version "2.04-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.04.tar.gz'
  source_sha256 '4f80122e4ea0b05079cad493e386564030f18c8d7b1f9af561df86985a653fe3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '991988b28ad10c15bc8780b34204b791e1af80abbc362509de2ae875eb0494c0',
     armv7l: '991988b28ad10c15bc8780b34204b791e1af80abbc362509de2ae875eb0494c0',
       i686: '8df994f64829f62d09433c98a5f9ba188278bd892bf0a2fb4e2cf147347f641d',
     x86_64: '664a71e5f564b4be60192f91c6ade574d42d6ca8378d18fe50f7c103535d142a'
  })
end
