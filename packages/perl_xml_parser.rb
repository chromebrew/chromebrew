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
    aarch64: 'fae543b502bbdd2a0e5341d254b815fb117ebd77c8185a67d98704785432c7fa',
     armv7l: 'fae543b502bbdd2a0e5341d254b815fb117ebd77c8185a67d98704785432c7fa',
       i686: '37263e99ed9c6e316d80c584efef84b161d81501be02dd4770e562f760c479ed',
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
