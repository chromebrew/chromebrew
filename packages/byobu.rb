require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.22'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a4235c78404fe1eb3303265e61225df398ba8e93fa22977642b2bde7d30da9a',
     armv7l: '5a4235c78404fe1eb3303265e61225df398ba8e93fa22977642b2bde7d30da9a',
       i686: 'e3f9e60cc4ff39109109261e8da95b38c27cadd59eb455b9d64238131434ed11',
     x86_64: '94c09f9bbe3ba0212201078338653097197b98f079291e4c6ef3f29aa24da23f'
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
