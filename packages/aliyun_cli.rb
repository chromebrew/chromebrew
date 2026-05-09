require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.13'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c365781152194321ff5f608cd4b500d272edc20e795ae1da738845761bc0be34',
     armv7l: 'c365781152194321ff5f608cd4b500d272edc20e795ae1da738845761bc0be34',
       i686: '99664265faf4aadbc078f6ab2df8470bc8d9794a93ccc04f3a917b22b58f4e71',
     x86_64: '8aeb3822e95c56ce9934b5876ca52b03261dacb3d5e3d56ab50029579a9bf3e1'
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
