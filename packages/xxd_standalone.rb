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
    aarch64: '1d93b4bc05065044f48feff289c3e35ec2a4997761fb1b3db0774eb2c7ba4fbe',
     armv7l: '1d93b4bc05065044f48feff289c3e35ec2a4997761fb1b3db0774eb2c7ba4fbe',
       i686: '8618e51bd186af6b4712fe8e0454e13289b27caa73f50789a4aad064511e1738',
     x86_64: '2c49d53444f0f61e1186d1f02aacdcb13b5e0e8beb15aa533624cdfb9f48f3e8'
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
