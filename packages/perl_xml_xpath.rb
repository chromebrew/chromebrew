# Adapted from Arch Linux perl-xml-xpath PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/perl-xml-xpath/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/perl'

class Perl_xml_xpath < PERL
  description 'A set of modules for parsing and evaluating XPath statements'
  homepage 'https://metacpan.org/release/XML-XPath'
  version '1.48'
  license 'PerlArtistic GPL'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MANWAR/XML-XPath-1.48.tar.gz'
  source_sha256 '7bc75be36b239e5b2e700a9570d2b53b43093d467f2abe6a743f9ff9093790cd'
  binary_compression 'tar.zst'

  depends_on 'perl_xml_parser'
end
