require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79aee96e85ab399b6dda892256cfdf842aa8add36620cdd0411b13c568583ff0',
     armv7l: '79aee96e85ab399b6dda892256cfdf842aa8add36620cdd0411b13c568583ff0',
       i686: '24b664c9b00ee4e138fdae6908fd89e5c23de4f4c56d7da8258afbf9ab31c073',
     x86_64: 'cb8e71509117c863c83ec277dd3eb5f3140130db03c1b68303b08e8a53305a7f'
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
