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

  binary_sha256({
    aarch64: '54e2d7d5233406f25f120f17a4787390bc146a980a87bfab768160418cf41189',
     armv7l: '54e2d7d5233406f25f120f17a4787390bc146a980a87bfab768160418cf41189',
       i686: 'b3bb94995c44e6deb3620f96a56d5e3f4a2e7d775aa83740045ab6719de295a0',
     x86_64: '8c5a8886d499f67b1df3ff62d6cc50605d4afe87122194e962ceeb4196e8b266'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_xml_parser'
end
