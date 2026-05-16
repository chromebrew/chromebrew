require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.15'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11926074cb70108492e32ef989b794b2dfdde42f63c1371830b60493513d7c8b',
     armv7l: '11926074cb70108492e32ef989b794b2dfdde42f63c1371830b60493513d7c8b',
       i686: '29f4a7e207d8ae23fa82238c43eaa3489b2ea31a3ae466ddbe4913be03fa1608',
     x86_64: '14db3d98f1792876ecf3f9cd1990ecd41b260a5de8ccc6a20129edae63dc79f9'
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
