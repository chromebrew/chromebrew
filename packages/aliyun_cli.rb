require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b4b1604bb09687bd3c9caf543bdd18cd3b3c48e079337bcc1313c8728e6dc10',
     armv7l: '0b4b1604bb09687bd3c9caf543bdd18cd3b3c48e079337bcc1313c8728e6dc10',
       i686: '97b1e6068502a053f53b247ff1c576c776d6bde98d08a0d8c51e307916318bb4',
     x86_64: '0ee2312de7dc4a211ce5aa44000188dd872578b1261ccacfd2ef0913818f4483'
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
