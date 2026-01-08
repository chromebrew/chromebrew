require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9deed6d524099fe73b4793cc21fe0b035a6ddb66d442ae000e8b96127d61cc03',
     armv7l: '9deed6d524099fe73b4793cc21fe0b035a6ddb66d442ae000e8b96127d61cc03',
       i686: '6c0b17854b45fe932c5b019e2fea70d45eddbd9ae0c539c854b7b3e51390224c',
     x86_64: '4b9e3823e274757a88b505d60c08d1adcf1cf87232b475528cbf0aba332481de'
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
