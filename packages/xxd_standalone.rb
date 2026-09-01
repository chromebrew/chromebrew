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
    aarch64: 'cd06f6ddf21cb0f8b040735c20cf5cb138df5ab531771e96d966bc127dbcdeae',
     armv7l: 'cd06f6ddf21cb0f8b040735c20cf5cb138df5ab531771e96d966bc127dbcdeae',
       i686: '57ad1cffca88229878c7465c50f39514af608af808e902a10934a3fb5a2b1472',
     x86_64: '16aad45a32bfc29f95bd9a226e9b42e30ae3e213b9c795e80aeb6764425a4396'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
