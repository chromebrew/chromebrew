require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b34f6cf15f65ffbc5f6c592533e5a8bfc985149752cb14d70daa24203c7007d',
     armv7l: '2b34f6cf15f65ffbc5f6c592533e5a8bfc985149752cb14d70daa24203c7007d',
       i686: '750c8e7c84b924db946e2b2d94af09544eeee0afbafe290c10c87f81612528fa',
     x86_64: 'd7dbb4b27c67caf6c66b493b270220b6aed83a5e8f2575691e62d9fc566b827b'
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
