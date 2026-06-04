require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.21'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99ad3261b65fee22bd6f2082fa0c11246ac9adc682cdc1467bd7f81144e1d9cd',
     armv7l: '99ad3261b65fee22bd6f2082fa0c11246ac9adc682cdc1467bd7f81144e1d9cd',
       i686: '17f9d4fe4eba781daf0144bde66a3e0488e84bd1a4ceb25830bf99faf6e9ffb8',
     x86_64: '95742a3f138b9d3e6bfff77e8163e6a07f79c411e48033667f0be2ae5d151fa3'
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
