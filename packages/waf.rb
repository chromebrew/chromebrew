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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waf/2.0.22_armv7l/waf-2.0.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waf/2.0.22_armv7l/waf-2.0.22-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waf/2.0.22_i686/waf-2.0.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/waf/2.0.22_x86_64/waf-2.0.22-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '732013cc9f066715cc03186d9d082d7096413b1fdd910ae71e93db6a4a162cc9',
     armv7l: '732013cc9f066715cc03186d9d082d7096413b1fdd910ae71e93db6a4a162cc9',
       i686: '531783e227612ebb76d64062f32769d92c1d21254397d2912d5dde8f40c3f685',
     x86_64: '5645ec0c6c283f41dc5a7b4e5d28f40137c330c591a330b2d5e40b4a8d86bd30'
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
