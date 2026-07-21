require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56579bebc2e559fe6a7adb4da14c2d5406cf82aa2dc8375d5ae65be46e054b1f',
     armv7l: '56579bebc2e559fe6a7adb4da14c2d5406cf82aa2dc8375d5ae65be46e054b1f',
       i686: '22993ac21f4819f0ec70902b1652fb64aadcd45f47cef1248492018c1467b8e7',
     x86_64: 'f149051f409244fd379b858aae799bc83b7b49b7ffeaadb1ce04ed595140d595'
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
