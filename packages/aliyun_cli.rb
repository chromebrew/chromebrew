require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b8cd6bcd27c28a00ce05d6441a9d3e17675a94ba42100d106ad1f054754f38e',
     armv7l: '8b8cd6bcd27c28a00ce05d6441a9d3e17675a94ba42100d106ad1f054754f38e',
       i686: 'd817064850b20048d6a400f925378bb135aa3ce09b05659a9ce0face8520b2cd',
     x86_64: 'ab4c15d51ff288b9ee40d99be525a91020ebe31d9d4e4646a324a39040c2fd39'
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
