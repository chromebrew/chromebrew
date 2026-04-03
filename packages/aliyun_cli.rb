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
    aarch64: 'a75f2b6ba5b80dd0be3faad0651a492aa114e13cf5844770a91507e606a28341',
     armv7l: 'a75f2b6ba5b80dd0be3faad0651a492aa114e13cf5844770a91507e606a28341',
       i686: '56f82211fc54c14fc0e8b8ba53f020e6cc88263133214650d5fa5e47b653e608',
     x86_64: '6a85fb63435088b494683a9c0c7c4a322110d2bf600d919112de4dd9e22672a0'
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
