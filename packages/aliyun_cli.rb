require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.9'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '450ca076a9a968211199cd0263c96884f76d90996cf42c5c26842bd8570277dc',
     armv7l: '450ca076a9a968211199cd0263c96884f76d90996cf42c5c26842bd8570277dc',
       i686: 'b91796560f945a891317bda385e2b9cbe7fd31213bc97522f47bffc41f97230a',
     x86_64: '8a42e467d68b9c6a04fe4a4e88a544e7231d756ea16a62c7f3843db15161a261'
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
