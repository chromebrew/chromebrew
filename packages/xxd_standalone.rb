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
    aarch64: 'f2bd390ce9f363c79e8c7964f87f88fb21ede03fbe9b9dfa4d5705a73f7df0a0',
     armv7l: 'f2bd390ce9f363c79e8c7964f87f88fb21ede03fbe9b9dfa4d5705a73f7df0a0',
       i686: '6e2f708fdd5359e3efd74952b9c45371add53b3089fd3e3cbb024654a7a944c5',
     x86_64: '570d9af2a689e7d4060f9fa316e7e73c76e484f4f8c7f349c6fe670f7104bd9f'
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
