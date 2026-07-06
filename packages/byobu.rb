require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.14'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '581953fc671290e1bfafdfd644c254361c0a8bce2b23011a28014b4318b366a5',
     armv7l: '581953fc671290e1bfafdfd644c254361c0a8bce2b23011a28014b4318b366a5',
       i686: '29c8da93bddec67203f288cba5f8de415be32c6b8eb609c701b5209a271d5f61',
     x86_64: '1ff73230ded9743006b960b6bd3380c5082605162612f9cb82aee83fec3036b5'
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
