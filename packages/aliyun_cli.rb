require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1cc055e0b1825e2ebc43ae3d382fdb8d5e8707d4c81cf3a55c7ff935aca051f',
     armv7l: 'c1cc055e0b1825e2ebc43ae3d382fdb8d5e8707d4c81cf3a55c7ff935aca051f',
       i686: '258465f4cf7ae875563ead5f9f3ec9030300bf9f6076074e7e502a0efc53b62c',
     x86_64: '0934cda47bbd40e65eb181e8ed2a7bad0880db3bd90af808db96944066c65d1b'
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
