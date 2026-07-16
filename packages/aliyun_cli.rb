require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dcb8e46e8fa9570d76fa169c853bc0b5f8887ecf75fd662fb6f89e7b6cae1cb2',
     armv7l: 'dcb8e46e8fa9570d76fa169c853bc0b5f8887ecf75fd662fb6f89e7b6cae1cb2',
       i686: '8ffdcdf3cbf0a0265d443ff59288b0d0189d341b9db40ff05f1fa3bd30d21a23',
     x86_64: 'ba57c1e712a7151e78f6f70b3a1e385db80c7db16e4a68ab9c099b52d4e94710'
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
