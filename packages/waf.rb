require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '2.0.22'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf/-/archive/waf-2.0.22/waf-waf-2.0.22.tar.bz2'
  source_sha256 '7368b14adba94467c920161aaca3e54384aca392acb7dc8ee37d53ce29dac781'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/waf-2.0.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/waf-2.0.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/waf-2.0.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/waf-2.0.22-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4c346775014015f83c14d94d99e2d6b5189aec388399140fc1ae060b4cf0d82f',
     armv7l: '4c346775014015f83c14d94d99e2d6b5189aec388399140fc1ae060b4cf0d82f',
       i686: '253756f480475b38c6470446f5467d1aad0e2a5b04766d4c901ea3d4bce735a4',
     x86_64: 'dbe0d9ec1bcb7d4700c866f66ddd0f8406643dc6462e5830521bb5c881cf0b71'
  })

  depends_on 'help2man'

  def self.build
    system './waf-light configure build'
    system './waf-light --tools=compat15'
    system 'help2man -N ./waf > waf.1'
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
    @wafenv = <<~WAFEOF
      # waf build system configuration
      export WAFDIR=#{CREW_LIB_PREFIX}
    WAFEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/waf", @wafenv)
  end
end
