require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.18'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '124600e2b7bb48db2dae1960688135eeffee860ba39bccfc684b5c23b72c3213',
     armv7l: '124600e2b7bb48db2dae1960688135eeffee860ba39bccfc684b5c23b72c3213',
       i686: '07250e8a22f0fbd64fed90f5d652ef7b962169355ffd8596b0e1a5fc8ee4b24f',
     x86_64: '08532aaab872b246dfd7d8d5e7545f949e1ac63b693fb063217c6a4c4f8647ee'
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
