require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e9aad6bdb152805ddfa417088a58dbadf98cade70ddfc64a3f2006f2e2f557c',
     armv7l: '7e9aad6bdb152805ddfa417088a58dbadf98cade70ddfc64a3f2006f2e2f557c',
       i686: '02d430128db51129be9b7a030f996831b331f6f8fa3b18ff2a9bce571439ce10',
     x86_64: '148b35cc846773e7b927bbb17219caf37c0117a183f9a335a104f3e3c2e7bf6f'
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
