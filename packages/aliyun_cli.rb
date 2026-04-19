require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a7b609421d44fa4d1e37c74b6a40a5726fccf25aa0e24509e2afa8d085529b3',
     armv7l: '2a7b609421d44fa4d1e37c74b6a40a5726fccf25aa0e24509e2afa8d085529b3',
       i686: '3c3e19ded5bd6d2086084731c590955dca2049d2e7bc1be1799292a085cf6471',
     x86_64: '58ccc0f5014d9826e585421c67caed60f32a7e63799a788988c7f069bd9872bf'
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
