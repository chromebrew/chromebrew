require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc2fa995acab1106523d06d22cd04f9115d3a2072dccec237db6f7f5705e6d46',
     armv7l: 'cc2fa995acab1106523d06d22cd04f9115d3a2072dccec237db6f7f5705e6d46',
       i686: '990b6d3c0ecc00c65e09bd163f37b94f65fcbf098a93481dad9cfc05186f6f52',
     x86_64: '8f670bd8c940d81764d9a04412a2638fb016b3491970ea3de24bff3f538ce63a'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    # Fix /usr/local/lib/byobu/include/common: line 52: get_distro: command not found
    system "sed -i 's,get_distro,echo ChromeOS,' ./usr/lib/byobu/include/common"
    # Fix for fhs compliance.
    if ARCH.eql?('x86_64')
      Dir['./usr/lib/byobu/*/**'].each do |file|
        system "sed -i 's,/lib/,/lib#{CREW_LIB_SUFFIX}/,g' #{file}" unless Dir.exist?(file)
      end
    end
  end

  autotools_install_extras do
    # Fix for fhs compliance.
    if ARCH.eql?('x86_64')
      Dir["#{CREW_DEST_PREFIX}/lib/byobu/*"].each do |lib|
        FileUtils.mv lib, "#{CREW_DEST_LIB_PREFIX}/byobu"
      end
      Dir["#{CREW_DEST_PREFIX}/lib/trustmux/*"].each do |lib|
        FileUtils.mv lib, "#{CREW_DEST_LIB_PREFIX}/trustmux"
      end
      Dir["#{CREW_DEST_PREFIX}/bin/*"].each do |bin|
        system "sed -i 's,/lib/,/lib#{CREW_LIB_SUFFIX}/,g' #{bin}"
      end
    end
  end
end
