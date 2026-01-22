require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '652c31b702c902626741e51079d00782da9fb0b4caa2e62519ce781bf4a9d683',
     armv7l: '652c31b702c902626741e51079d00782da9fb0b4caa2e62519ce781bf4a9d683',
       i686: '8797c889772511d49ce90531c1bbf9e472c3e087de9f50fade4c4d182d435107',
     x86_64: '91dd0c960ce60ef160ad4b698287ee5604cd32024c7b7a0a9cefa8448301448b'
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
