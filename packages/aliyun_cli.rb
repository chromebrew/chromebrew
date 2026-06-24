require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a33f9734dc10356793182fea6fc8df2e555f5717af9efc34d0915d63e3122093',
     armv7l: 'a33f9734dc10356793182fea6fc8df2e555f5717af9efc34d0915d63e3122093',
       i686: '0bde0c8aefacb5d3f2d8827a45d4f34d882c2b8fc7aeb38b4f96a6757e8b82b2',
     x86_64: 'c79d4360f98b447a4a7f32b63d0a3ab492932180f429dc03b827938207853de2'
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
