# Adapted from Arch Linux perl-xml-xpath PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/perl-xml-xpath/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/perl'

class Perl_xml_xpath < PERL
  description 'A set of modules for parsing and evaluating XPath statements'
  homepage 'https://metacpan.org/release/XML-XPath'
  version '1.49'
  license 'PerlArtistic GPL'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/M/MA/MANWAR/XML-XPath-#{version}.tar.gz"
  source_sha256 '9c84a51be4cdb47bf88766ecab051fe092016472969e39f4acdba009885faabe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2aeab378004fec997212b1bcc2263a4a8475d2fe8976bbc3f9b4cba8e957e68',
     armv7l: 'a2aeab378004fec997212b1bcc2263a4a8475d2fe8976bbc3f9b4cba8e957e68',
       i686: '56a39ca59c72140b27c2b06eb6ba4daf3db34e97d1a498ca94e3e0c88555bc64',
     x86_64: 'fc6227e0d439a3a44c31339c56ed1b00a4a95a03c5365d6a41676773da1c176b'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_xml_parser'
end
