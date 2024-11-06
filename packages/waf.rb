require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '2.0.24'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf.git'
  git_hashtag "waf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1bab4de03c7f6aebcbce73460a06d4d4c1eefa22889230a866729ff8cdd3f8b',
     armv7l: 'f1bab4de03c7f6aebcbce73460a06d4d4c1eefa22889230a866729ff8cdd3f8b',
       i686: '99ce239ddf42677e615597fefe308e29b55b9f8967d0fd3a83e2595a3e17bc3f',
     x86_64: 'f05712b984add199554d6b32df0b2bf677a8e88a92385712496255b005d784ad'
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
