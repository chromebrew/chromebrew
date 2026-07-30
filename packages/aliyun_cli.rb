require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '599d97a516468cead71032b9e3e1ce8b61410a9b6fbe0f5317b252c01fed8226',
     armv7l: '599d97a516468cead71032b9e3e1ce8b61410a9b6fbe0f5317b252c01fed8226',
       i686: '4d047d07d19bbf5bc7b19b7eaa11e36ca862dfbb893fb88afce63e93ec0215d7',
     x86_64: '31176a584f2a829101347dbecc15f780edbbd3ee46ed3f29150fb31fa03c9d8f'
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
