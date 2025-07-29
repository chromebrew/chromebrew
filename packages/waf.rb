require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '2.1.6'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf.git'
  git_hashtag "waf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6577ea095f3a72ccce555f9f7bea001dd5b69dca062bce08edc9b768cb30ea6c',
     armv7l: '6577ea095f3a72ccce555f9f7bea001dd5b69dca062bce08edc9b768cb30ea6c',
       i686: 'c3feb9fefebb75261438147a2645ab4cc6570794355f152e21854cad600def87',
     x86_64: '8c9c541b7d8f7d637456572ffe8b3c88dc5135859d53653ced1e0c414559843b'
  })

  depends_on 'help2man'

  def self.build
    system './waf-light configure build'
    system "./waf-light --tools=compat15 --prelude=\$'\tfrom waflib.extras import compat15\n'"
    system 'help2man -N ./waf > waf.1'
    system "sed -i 's,/lib/,/lib64/,' waf" if ARCH == 'x86_64'
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
