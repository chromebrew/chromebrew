require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29ddb40ae4f466925b636b3c8460913f69428735da8bf8f69398ee209480e61b',
     armv7l: '29ddb40ae4f466925b636b3c8460913f69428735da8bf8f69398ee209480e61b',
       i686: '9dd989d0bdc9598e73515dd3e7888639a7c20a73da9e78a78f30128d039f9e0d',
     x86_64: '5578e72cd9d44f940c775ddfe4b50e910375662d11800f412074294c08dedbd2'
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
