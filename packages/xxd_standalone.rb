require 'package'
Package.load_package("#{__dir__}/vim_runtime.rb")

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'https://www.vim.org/'
  version Vim_runtime.version
  license 'GPL-2'
  compatibility 'all'
  source_url Vim_runtime.source_url
  git_hashtag Vim_runtime.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5f27bd110d4a105be546475a9ce2c82f14784220f33468e620afd917fc2c6b3',
     armv7l: 'f5f27bd110d4a105be546475a9ce2c82f14784220f33468e620afd917fc2c6b3',
       i686: '7ba67f0ee5e43593001858251984fb96c7e99bf92f835840222b32e1c580027a',
     x86_64: '0e4896bd191cf54b52c9690eead2cd197935716fca97153b48ae544525255058'
  })

  depends_on 'glibc' => :executable_only

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
