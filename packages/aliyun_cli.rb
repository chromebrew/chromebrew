require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.18'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99ad3261b65fee22bd6f2082fa0c11246ac9adc682cdc1467bd7f81144e1d9cd',
     armv7l: '99ad3261b65fee22bd6f2082fa0c11246ac9adc682cdc1467bd7f81144e1d9cd',
       i686: '12b164c8b1bbf66b5aff0774d755a6b1b58ff0ee760887748d2564d6345fc6c3',
     x86_64: 'f07ebaf5bb5d6504ec2a347476a64a1dfb6790658603b146668a03cee0c3dc62'
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
