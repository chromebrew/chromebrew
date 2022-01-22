require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '2.0.23'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf.git'
  git_hashtag "waf-#{version}"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/waf-2.0.23-chromeos-armv7l.tpxz',
     armv7l: 'file:///usr/local/tmp/packages/waf-2.0.23-chromeos-armv7l.tpxz',
       i686: 'file:///usr/local/tmp/packages/waf-2.0.23-chromeos-i686.tpxz',
     x86_64: 'file:///usr/local/tmp/packages/waf-2.0.23-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '147ffce125636a9b1f2929a20169e07545211b7b80d4ac6bd757587b04a10697',
     armv7l: '147ffce125636a9b1f2929a20169e07545211b7b80d4ac6bd757587b04a10697',
       i686: 'd5d5f0efaa3e9fd0dd6d60bc9f5c0df71447b7cd498900a26defb75f0413a2d3',
     x86_64: 'c415edd52cb5fa0de773b6ae6d6a4975742eee186e86171dc8899973a5e0a541'
  })

  depends_on 'help2man'

  def self.build
    system './waf-light configure build'
    system "./waf-light --tools=compat15 --prelude=\$'\tfrom waflib.extras import compat15\n'"
    system 'help2man -N ./waf > waf.1'
    case ARCH
    when 'x86_64'
      system "sed -i 's,/lib/,/lib64/,' waf"
    end
  end

  def self.install
    @dest_dirs = %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/bin #{CREW_DEST_LIB_PREFIX}
                    #{CREW_DEST_MAN_PREFIX}/man1]
    @dest_dirs.each do |dir|
      FileUtils.mkdir_p dir
    end
    FileUtils.cp 'waf', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'waf-light', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp 'waf.1', "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.cp_r 'waflib', "#{CREW_DEST_LIB_PREFIX}/"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @wafenv = <<~WAFEOF
      # waf build system configuration
      export WAFDIR=#{CREW_LIB_PREFIX}
    WAFEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/waf", @wafenv)
  end
end
