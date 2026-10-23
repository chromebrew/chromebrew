require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.5.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02e4557296bc571e3495ebbe16f6d600aab491be63dba0ef1ba2ce860d9e6cad',
     armv7l: '02e4557296bc571e3495ebbe16f6d600aab491be63dba0ef1ba2ce860d9e6cad',
       i686: '1eaa17ac6f9d5eadd965b89c9472d0697a6153842a08ff975501ff0c96bbdfd4',
     x86_64: '35dcca6b57dea273af16afecddb2bb1c0b1d0fa8fa0a617e99cbb6d437ded2d2'
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
