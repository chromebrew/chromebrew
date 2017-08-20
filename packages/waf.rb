require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '1.9.13'
  source_url 'https://github.com/waf-project/waf/archive/waf-1.9.13.tar.gz'
  source_sha256 '08d41e9e50398b2f07d74b0cef7b9f02d33787d6d27d2a0e6df5732bbd95bebc'

  depends_on 'help2man'
  depends_on 'python27' unless File.exists? '/usr/local/bin/python'

  def self.build
    system './waf-light configure build'
    system './waf-light --tools=compat15'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "help2man -N ./waf > waf.1"
    case ARCH
    when 'x86_64'
      system "sed -i 's,/lib/,/lib64/,' waf"
    end
    system "cp waf #{CREW_DEST_PREFIX}/bin"
    system "cp waf-light #{CREW_DEST_PREFIX}/bin"
    system "cp waf.1 #{CREW_DEST_PREFIX}/man/man1"
    system "cp -r waflib/ #{CREW_DEST_LIB_PREFIX}"
  #end

  # uncomment after PR #1110 is merged
  #def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export WAFDIR=#{CREW_LIB_PREFIX}' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
