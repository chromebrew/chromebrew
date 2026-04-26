require 'package'

class Colordiff < Package
  description "The Perl script colordiff is a wrapper for 'diff' and produces the same output but with pretty 'syntax' highlighting."
  homepage 'https://www.colordiff.org/'
  version '1.0.22'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.colordiff.org/colordiff-#{version}.tar.gz"
  source_sha256 'f96f73c54521c53f14dc164d5a3920c9ca21a0e5f8e9613f43812a98af3e22af'

  depends_on 'perl' => :executable

  no_compile_needed

  def self.patch
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' colordiff.pl"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colordiff.pl"
  end

  def self.install
    FileUtils.install 'cdiff.sh', "#{CREW_DEST_PREFIX}/bin/cdiff", mode: 0o755
    FileUtils.install 'colordiff.pl', "#{CREW_DEST_PREFIX}/bin/colordiff", mode: 0o755
    FileUtils.install 'colordiffrc', "#{CREW_DEST_PREFIX}/etc/colordiffrc", mode: 0o644
    FileUtils.install 'cdiff.1', "#{CREW_DEST_PREFIX}/man/man1/cdiff.1", mode: 0o644
    FileUtils.install 'colordiff.1', "#{CREW_DEST_PREFIX}/man/man1/colordiff.1", mode: 0o644
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.ln_s "#{CREW_PREFIX}/etc/colordiffrc", "#{CREW_DEST_HOME}/.colordiffrc"
  end
end
