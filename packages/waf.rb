require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '1.9.13-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf/-/archive/waf-2.0.22/waf-waf-2.0.22.tar.bz2'
  source_sha256 '7368b14adba94467c920161aaca3e54384aca392acb7dc8ee37d53ce29dac781'

  depends_on 'help2man'
  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.build
    system './waf-light configure build'
    system './waf-light --tools=compat15'
    system "help2man -N ./waf > waf.1"
    case ARCH
    when 'x86_64'
      system "sed -i 's,/lib/,/lib64/,' waf"
    end
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp waf #{CREW_DEST_PREFIX}/bin"
    system "cp waf-light #{CREW_DEST_PREFIX}/bin"
    system "cp waf.1 #{CREW_DEST_PREFIX}/man/man1"
    system "cp -r waflib/ #{CREW_DEST_LIB_PREFIX}"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # waf build system configuration
      export WAFDIR=#{CREW_LIB_PREFIX}
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/waf", @env)
  end
end
