require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.1.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c35528808fb887b6bf47fba72d4f940f67f62c76f0be2cecb1c1754e5c47f4e',
     armv7l: '3c35528808fb887b6bf47fba72d4f940f67f62c76f0be2cecb1c1754e5c47f4e',
       i686: '4570278a3f9a44a73de1f67c1d47c9531806665730f6f80a0da439a611e904f9',
     x86_64: '209b485c8d0261dcef605e02b27c346e147613f7a1f5ae5fc7cf7a23772a95dc'
  })

  depends_on 'glibc' # R
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
