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
    aarch64: 'b369e5bc47911e7408ef6f58b18311faecff3e101d58979e4f7d94c18e7e79b1',
     armv7l: 'b369e5bc47911e7408ef6f58b18311faecff3e101d58979e4f7d94c18e7e79b1',
       i686: 'd9f47f712d1d1539b8b3bd1b66f9e335bdaef4373dc42be2356987a1aae20929',
     x86_64: '875757eb64a73d26edd26ba767a92ef4e55bd972ae79e0a0f726ddd6bd4940dd'
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
