require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.22'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb389f6bbdf02bf039da813ea1058d2afd8e8c82dc9fd6573f052f95ab35308a',
     armv7l: 'fb389f6bbdf02bf039da813ea1058d2afd8e8c82dc9fd6573f052f95ab35308a',
       i686: 'e81147c8c3950f635398b7dfc554f7e59c5ba7264cbf7fdd6226049098dde706',
     x86_64: 'dcca0214c451ddf3b147833206de3462a003c84fcfa3c8fe209e2869396fa2bd'
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
