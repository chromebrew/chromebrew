require 'buildsystems/autotools'

class Openjade < Autotools
  description "James Clark's implementation of DSSSL (Document Style Semantics and Specification Language) an ISO standard for formatting SGML (and XML) documents."
  homepage 'http://www.openjade.org/'
  version '1.3.2'
  license 'BSD'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/openjade/openjade/#{version}/openjade-#{version}.tar.gz"
  source_sha256 '1d2d7996cc94f9b87d0c51cf0e028070ac177c4123ecbfd7ac1cb8d0b7d322d1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1f1cd5d4690bf12fc19a13eb603ae1211ca02ab50dc9c1580de049fcb1d1cda',
     armv7l: 'c1f1cd5d4690bf12fc19a13eb603ae1211ca02ab50dc9c1580de049fcb1d1cda',
       i686: '1dd7b2d2b0a75804647b62a0ace59653f4cb8977346e2003782b804faf944301',
     x86_64: 'c32a34cef134b8602840e580d774387713cbdee1139a3b041b626f9f6106424b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'opensp' # R

  def self.patch
    # See https://sourceforge.net/p/openjade/bugs/140/#5e5f.
    system "sed -i '21d' msggen.pl"
    system "sed -i '6iuse Getopt::Std;' msggen.pl"
    system "sed -i 's,&Getopts,getopts,g' msggen.pl"
    Dir['**/*.pl'].each do |perlfile|
      puts "Patching #{perlfile}...".orange
      system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' #{perlfile}"
    end
  end

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/openjade", "#{CREW_DEST_PREFIX}/bin/jade"
  end
end
