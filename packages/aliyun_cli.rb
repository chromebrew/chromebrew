require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.23'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c6dfa540fccf26d4cc1c8a5ef0e5729d95e0f88e288b86c6763cb36f147bde4',
     armv7l: '9c6dfa540fccf26d4cc1c8a5ef0e5729d95e0f88e288b86c6763cb36f147bde4',
       i686: 'a7274f5feb9ba00ced096c9b8a8f1b624ad1e2ec23019660f6dccd26bd8481ec',
     x86_64: 'c0bff9402cb783f0e1c8d29010166e7124aa4f8612d11bd1a17710ecfd65e470'
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
