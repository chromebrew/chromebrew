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
    aarch64: '4ca5eeecc6744bdbd76a97cbfc422402478f267d8fb2480a4ffb2be1dfe691e5',
     armv7l: '4ca5eeecc6744bdbd76a97cbfc422402478f267d8fb2480a4ffb2be1dfe691e5',
       i686: 'ce0fe6d74c36fc9daa2162fd4d5296afad725d7a7afdf4c51e93162b757f4ce4',
     x86_64: 'c55cecc088d9d1b32481c1283af94274d95416b5c4a955567625b7013d961fc4'
  })

  depends_on 'perl' => :logical
end
