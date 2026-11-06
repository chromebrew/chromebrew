require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.5.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f8517167b41dd0f640c2cbc0f62e8aed84d64a3ffc7207095f462dee91d20d2',
     armv7l: '0f8517167b41dd0f640c2cbc0f62e8aed84d64a3ffc7207095f462dee91d20d2',
       i686: 'ba8444dfbb7115bb2e6b5140d1940bc4bdd26d3e5ad42b7b09c6f1e8af798da6',
     x86_64: 'b665a8e0eb0f2a6dd4226bb07a651ec8c7a78d7fd399495625bfd7e3c2d6a407'
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
