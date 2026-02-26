require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.10'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '532fe06491f11140e031c5b47531972bd7ce1162053136bb1de00b6b2144471e',
     armv7l: '532fe06491f11140e031c5b47531972bd7ce1162053136bb1de00b6b2144471e',
       i686: '8c04a58d51efac4e657ad90b04760cbd6ee2613d335aaea8624cdf7ada959ed6',
     x86_64: '6dd1de964f462373296c5075bdcf853a9bb31dc14d5c3e1ed6870a31662f5480'
  })

  depends_on 'glibc' => :executable_only
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
