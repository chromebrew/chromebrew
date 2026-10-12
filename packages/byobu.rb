require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '7.21'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa1fdeea5d8661eafea6bf0b8f97077079499db46986a0691552e483eb864ccf',
     armv7l: 'fa1fdeea5d8661eafea6bf0b8f97077079499db46986a0691552e483eb864ccf',
       i686: '4117b57b26e9ce4a3c01c8499e7badfb51b0ead2efeeb3e5c53ce1fc9255f108',
     x86_64: 'c983e0935a6c5ade4460acedf03ca8c209e8ada604f92a2ca2191f21bd57dcba'
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
