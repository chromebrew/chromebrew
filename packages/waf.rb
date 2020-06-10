require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '1.9.13'
  compatibility 'all'
  source_url 'https://github.com/waf-project/waf/archive/waf-1.9.13.tar.gz'
  source_sha256 '08d41e9e50398b2f07d74b0cef7b9f02d33787d6d27d2a0e6df5732bbd95bebc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/waf-1.9.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/waf-1.9.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/waf-1.9.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/waf-1.9.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de828d9a81f18da0c7dc966623e2f41815f6bd42a723b5bd3eda444eb9b93538',
     armv7l: 'de828d9a81f18da0c7dc966623e2f41815f6bd42a723b5bd3eda444eb9b93538',
       i686: 'a18ef4d76efe3e6fd2e125c0df3a589851d11c06dd7c22cdf8bb1ec7e0a9ca20',
     x86_64: 'b577a4768c54331ac09d4d6eb4e6258ad6a0e6b1267cec468c5dd33c1b01bff4',
  })

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
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export WAFDIR=#{CREW_LIB_PREFIX}' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
