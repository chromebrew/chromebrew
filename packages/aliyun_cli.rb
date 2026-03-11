require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.13'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '944d644440d51d5005d987ad946b2d5e572c23275cde936aede0701051118a40',
     armv7l: '944d644440d51d5005d987ad946b2d5e572c23275cde936aede0701051118a40',
       i686: '4e8a8b39a65e000c541c7f43db8041be56149f2c83d15a31d8d2d8bdafb4f2d4',
     x86_64: '41987d3d07e0a8f37cd6ec1fc9eb363cfaf11f19c30496da42e831543c4beda7'
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
