require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '379f3808f8750e31fb58a91e1639d9234c2ea55c7bfc264db1080bb114458a31',
     armv7l: '379f3808f8750e31fb58a91e1639d9234c2ea55c7bfc264db1080bb114458a31',
       i686: '089018fa2ed41a4b4fff4af73e0a71c4ff0667adfe48f7367284cf4f5e7cff18',
     x86_64: '29502e828ece688a7ad636fa19a70425c0842a481c26d4e1e8892155bcf6df69'
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
