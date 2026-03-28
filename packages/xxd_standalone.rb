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
    aarch64: '8fa03db4693eef12a75d1d37239ca1512f80b2fe8881045af2c684363da89b73',
     armv7l: '8fa03db4693eef12a75d1d37239ca1512f80b2fe8881045af2c684363da89b73',
       i686: '481d1931ae6b2ca1fe5bd54a94edde23605216a87b6d0c85f0d87e1f2a7a0f32',
     x86_64: '21946a1bd882a201911dfb311494f8843f2c4691aac40853d0899fb4f5e4987a'
  })

  depends_on 'glibc' => :executable

  ignore_updater

  def self.build
    system 'make -C src/xxd xxd'
  end

  def self.install
    FileUtils.install 'src/xxd/xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    FileUtils.install 'runtime/doc/xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
  end
end
