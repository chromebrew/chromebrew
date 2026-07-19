require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version "2.59-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-#{version.split('-').first}.tar.gz"
  source_sha256 'a358fd7c49f5e27717a644a9102bd21dc7fc25a415983279c59b1580e2b62a58'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ec9395662e92a14ceb941b461d3ab2d0e533f17e1ee4b910a28868bcd43eb88',
     armv7l: '6ec9395662e92a14ceb941b461d3ab2d0e533f17e1ee4b910a28868bcd43eb88',
       i686: '8f911ffd5efe0147f470cbc53d221cad0d3519854e1e3c6c83c28c201208b321',
     x86_64: '9db09f2f159cc258650e00b38fa713a4aaf9e8fcc7616561b0fd175599465ca1'
  })

  depends_on 'expat' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_class_inspector' => :executable
  depends_on 'perl_file_sharedir' => :executable
  depends_on 'perl_file_sharedir_install' => :executable

  conflicts_ok # conflicts with perl_date_format
end
