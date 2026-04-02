require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '2.1.9'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://gitlab.com/ita1024/waf.git'
  git_hashtag "waf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89c899a5ac1d2f6b90bbb55490979fee85f518f958baed25f53e20168fe72245',
     armv7l: '89c899a5ac1d2f6b90bbb55490979fee85f518f958baed25f53e20168fe72245',
       i686: 'd3bb67e707b227a0262e7f72e1a62d8bb922835d45f8c983430c271e1dd092f1',
     x86_64: 'ad7d49cf50682f141085d1fd1b11be44d5d9c96ed884a655af0f0185c3cf8b35'
  })

  depends_on 'help2man' => :build

  print_source_bashrc

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
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/waf", <<~WAFEOF
      # waf build system configuration
      export WAFDIR=#{CREW_LIB_PREFIX}
    WAFEOF
  end
end
