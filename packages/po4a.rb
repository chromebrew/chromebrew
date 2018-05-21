require 'package'

class Po4a < Package
  description 'Maintain the translations of your documentation with ease (PO for anything)'
  homepage 'https://www.po4a.org'
  version '0.52'
  source_url 'https://github.com/mquinson/po4a/archive/v0.52.tar.gz'
  source_sha256 '547c410ad3bb8e5fd3939a6acdd39713529187be05fca7235095d57d3f0c6cfc'

  depends_on 'perl_module_build' => :build
  depends_on 'perl_sgmls' => :build
  depends_on 'perl_locale_gettext' => :build
  depends_on 'perl_text_wrapi18n' => :build
  depends_on 'perl_read_key' => :build
  depends_on 'perl_gcstring_linebreak' => :build
  depends_on 'xsltproc' => :build

  def self.build
    system "perl", "Build.PL"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' Build"
    system "perl", "Build"
    system "perl", "Build.PL"
    system "sed -i \"s,/usr/bin,#{CREW_PREFIX}/bin,g\" Build"
    system "perl", "Build"
  end

  def self.install
    system "perl Build install"
  end
end
