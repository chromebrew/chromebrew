require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.5.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87523c3f51e357ab0846a056bca58b260800ea527b1be9b5f07652afd4054af2',
     armv7l: '87523c3f51e357ab0846a056bca58b260800ea527b1be9b5f07652afd4054af2',
       i686: 'c495e9843a68ebaeaab3bb569e7194e095e02241662326e638affb348dbf0ee3',
     x86_64: '06af7b45390125dac409e2403b8a8c483792304eb5730f3cc0baa454ea833b4b'
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
