# Adapted from Arch Linux po4a PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/po4a/trunk/PKGBUILD

require 'package'

class Perl_po4a < Package
  description 'Tools for helping translation of documentation'
  homepage 'https://po4a.org/'
  version '0.63'
  compatibility 'all'
  license 'GPL'
  source_url 'https://github.com/mquinson/po4a/archive/v0.63.tar.gz'
  source_sha256 '534a050af6e8d8d2acd5dd32b66c9a15f64106f022efef72cd82c175de34e595'

  depends_on 'perl'
  depends_on 'gettext'
  depends_on 'perl_yaml_tiny'
  depends_on 'perl_gcstring_linebreak'
  depends_on 'perl_text_wrapi18n' => ':build'
  depends_on 'perl_locale_gettext' => ':build'
  depends_on 'perl_term_readkey' => ':build'

  def self.build
    @perl5lib = `perl -le 'print $INC[0]'`.chomp
    system "env PERL5LIB=#{@perl5lib} \
      perl Build.PL installdirs=vendor create_packlist=0"
    system 'LC_ALL=en_US.UTF-8 perl Build'
  end

  def self.install
    system "perl Build destdir=#{CREW_DEST_DIR} install"
  end
end
