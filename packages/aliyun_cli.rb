require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6f9002773b46dbf20cd6eb549b5cb1b326ce3022abc1a092148c1033e446f66',
     armv7l: 'd6f9002773b46dbf20cd6eb549b5cb1b326ce3022abc1a092148c1033e446f66',
       i686: '99fa0243b1bc194fb3eb39aa32e88233d6bdb6314ee9ae89244bc3dd03635cfa',
     x86_64: '99c8931d3e521a740a21e8df19a48190ed10494997790125898e428a6b0e4a31'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'out/aliyun', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'aliyun --help' to get started.\n"
  end
end
