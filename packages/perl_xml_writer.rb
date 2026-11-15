require 'buildsystems/perl'

class Perl_xml_writer < PERL
  description 'Perl extension for writing XML documents.'
  homepage 'https://metacpan.org/pod/XML::Writer'
  version "0.900-#{CREW_PERL_VER}"
  license 'Copyright (c) 2004-2010 Joseph Walton'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/J/JO/JOSEPHW/XML-Writer-#{version.split('-')[0]}.tar.gz"
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '255d42097754e6cd09a65ede0a2603fff1b471b48436497942c5c04107a7dccc',
     armv7l: '255d42097754e6cd09a65ede0a2603fff1b471b48436497942c5c04107a7dccc',
       i686: 'c1dee624b8acd56e0ab1b8e88d1d4a118007c5932f7ddeee56fa79a32528a1af',
     x86_64: '21a619197eae95f7a079c37a47fb5045af7aa6be7af695a76e54657c44d43c10'
  })

  depends_on 'perl' => :logical
end
