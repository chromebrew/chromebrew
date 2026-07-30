require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da9cb4bcecb9968cd824f6ed2d926ec8306a70dabb3376e42441ea1b0245e3e7',
     armv7l: 'da9cb4bcecb9968cd824f6ed2d926ec8306a70dabb3376e42441ea1b0245e3e7',
       i686: '068eb15599a361667796c5223578f99b216e399230db65b692887edc1fb0acec',
     x86_64: '9656d7a7fa05cfbc812eb9a10b8ee7293e897df4ad9bdfdc87d54af62fe76054'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
