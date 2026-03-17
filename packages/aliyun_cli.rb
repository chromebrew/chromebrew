require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f96d25a1e5f0c33504e42c5bb7b2408541417ca46783a17f6939234d5370d333',
     armv7l: 'f96d25a1e5f0c33504e42c5bb7b2408541417ca46783a17f6939234d5370d333',
       i686: '0c4ae9d367f303722a833be2d25cf75579793525b95b986df376fb96384f6628',
     x86_64: '4632da05c7023d2768bb7cd367ea5085e8809d2f715e040dd570f7ed1386463d'
  })

  depends_on 'glibc' => :executable_only
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
