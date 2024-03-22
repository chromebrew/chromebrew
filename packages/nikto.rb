require 'package'

class Nikto < Package
  description 'Open Source (GPL) web server scanner which performs comprehensive tests against web servers'
  homepage 'https://cirt.net/Nikto2'
  version '2.5.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/sullo/nikto.git'
  git_hashtag "nikto-#{version}"

  depends_on 'perl'
  depends_on 'perl_net_ssleay'

  no_compile_needed

  def self.patch
    # Fix /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,/usr/bin/env perl,' program/replay.pl"
  end

  def self.build
    File.write 'nikto.env', <<~EOF
      NIKTO_DIR=#{CREW_PREFIX}/share/nikto
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nikto"
    FileUtils.install 'nikto.env', "#{CREW_DEST_PREFIX}/etc/env.d/10-nikto", mode: 0o644
    FileUtils.install 'program/nikto.conf.default', "#{CREW_DEST_HOME}/nikto.conf", mode: 0o644
    FileUtils.install 'program/docs/nikto.1', "#{CREW_DEST_MAN_PREFIX}/man1/nikto.1", mode: 0o644
    FileUtils.mv Dir['program/*'], "#{CREW_DEST_PREFIX}/share/nikto"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nikto/nikto.pl", "#{CREW_DEST_PREFIX}/bin/nikto"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nikto/replay.pl", "#{CREW_DEST_PREFIX}/bin/replay"
  end

  def self.postinstall
    puts "\nThe configuration file is located at #{HOME}/nikto.conf.".lightblue
    puts "\nExample: nikto -host https://chromebrew.github.io/\n".lightblue
  end
end
