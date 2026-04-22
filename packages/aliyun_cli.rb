require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.10'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ed7993047d943e4db660b9691a2cce9ee73919e3c522921cb768b95137bcf5a',
     armv7l: '7ed7993047d943e4db660b9691a2cce9ee73919e3c522921cb768b95137bcf5a',
       i686: '95f5cf1a0ecbae2f665dd7b7d629208f5bf44cd5dab6b043a756ffc28041884c',
     x86_64: '733dbd6033ba27ba8e8d2215a28d6c7099e2e7ccbd4cd350c993931e082ca1f3'
  })

  depends_on 'glibc' => :executable
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
