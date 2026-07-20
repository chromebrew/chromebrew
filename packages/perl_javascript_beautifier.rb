require 'package'

class Perl_javascript_beautifier < Package
  description 'command tool to beautify your javascript files'
  homepage 'https://metacpan.org/dist/JavaScript-Beautifier'
  version "0.25-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/F/FA/FAYLAND/JavaScript-Beautifier-#{version.split('-')[0]}.tar.gz"
  source_sha256 '5ecf68b9a86c40249823eeaa1c055baf9249dbcb7eff9da541af86b4fcf04bdd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d487bf874eaaf660ca22545bac11adf72e8e2850f9f8969d40a83c43c8a3f63',
     armv7l: '3d487bf874eaaf660ca22545bac11adf72e8e2850f9f8969d40a83c43c8a3f63',
       i686: '37e5c9efcc79fdfd424c2dc73504a0e99045778ec9c3fcb427a8db507701d4de',
     x86_64: 'c3fa7419c57d4d1d473bba24d134c0a04c3d0ab08d97b3d981dc983dfceeff6d'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_module_build' => :build

  def self.build
    system 'perl Build.PL && ./Build'
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' bin/js_beautify.pl"
  end

  def self.check
    system './Build test'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/perl5/site_perl"
    FileUtils.install 'bin/js_beautify.pl', "#{CREW_DEST_PREFIX}/bin/js_beautify.pl", mode: 0o755
    FileUtils.ln_s "#{CREW_PREFIX}/bin/js_beautify.pl", "#{CREW_DEST_PREFIX}/bin/js_beautify"
    FileUtils.install 'blib/bindoc/js_beautify.pl.1', "#{CREW_DEST_MAN_PREFIX}/man1/js_beautify.pl.1", mode: 0o644
    FileUtils.ln_s "#{CREW_MAN_PREFIX}/man1/js_beautify.pl.1.zst", "#{CREW_DEST_MAN_PREFIX}/man1/js_beautify.1.zst"
    FileUtils.mv 'blib/lib/Code', "#{CREW_DEST_PREFIX}/share/perl5/site_perl"
    FileUtils.mv 'blib/lib/JavaScript', "#{CREW_DEST_PREFIX}/share/perl5/site_perl"
    FileUtils.install 'blib/libdoc/Code::TidyAll::Plugin::JSBeautifier.3', "#{CREW_DEST_MAN_PREFIX}/man3/Code::TidyAll::Plugin::JSBeautifier.3", mode: 0o644
    FileUtils.install 'blib/libdoc/JavaScript::Beautifier.3', "#{CREW_DEST_MAN_PREFIX}/man3/JavaScript::Beautifier.3", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'js_beautify' to get started.\n"
  end
end
