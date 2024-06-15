require 'buildsystems/perl'

class Perl_text_csv < PERL
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version '2.04-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.04.tar.gz'
  source_sha256 '4f80122e4ea0b05079cad493e386564030f18c8d7b1f9af561df86985a653fe3'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'aa1eec639e95448e93677f32c1505b866956fa06c054cb4c88d0e24c2d0fc19a',
    aarch64: 'de5d6f10d94ecc36811b57f44e556a3eae4c49b3e364654f3fcccaf20c19c8cd',
     armv7l: 'de5d6f10d94ecc36811b57f44e556a3eae4c49b3e364654f3fcccaf20c19c8cd',
     x86_64: '7d45b7eb1b61697db117590ee41b21a2c3edeb76d02858c555fd2bf2feb5225c'
  })
end
