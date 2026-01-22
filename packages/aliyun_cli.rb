require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79ff2bb65c12dd343fcc5df3b0c7e3958f991de2c9de46dd1893814e1396d6e2',
     armv7l: '79ff2bb65c12dd343fcc5df3b0c7e3958f991de2c9de46dd1893814e1396d6e2',
       i686: 'aaac10ffec9e93ef154db92830b962c70c8722fdd20d012b6cccac9520728b31',
     x86_64: '9b2414bc814fa7727d06b4470aafb68eda77d69caf10781e8744909eddcf2437'
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
