require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a7813c34b62e2380d2e3187c175575363d01c3aca7a5883a4d09399f9df3b32',
     armv7l: '8a7813c34b62e2380d2e3187c175575363d01c3aca7a5883a4d09399f9df3b32',
       i686: 'c68cb651270fca10d1725e5ac2414f17202847e10cb726e07f9f409cb0f48269',
     x86_64: '3b291c82d6334cc68468fb1cf960d8ebff0c12c67534d46588894504116db4e0'
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
