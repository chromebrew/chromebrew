require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd34abba2b1baaa79526bf9d97feb979a104a35bef4f59a495e7c9031e3a9e6e8',
     armv7l: 'd34abba2b1baaa79526bf9d97feb979a104a35bef4f59a495e7c9031e3a9e6e8',
       i686: '23daa4bb35b7f83db0800df5fe6e4b373663f1450ba22f5b3e54f1ba382708cf',
     x86_64: '9c04188650cc7a8607c1f673b837fba703012a80281930258cc9f7701c0a3257'
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
