require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8cba0d82fa859d3dfd655e6cad0a4c012416bca1aa13dd83a8193bdedda2e7b',
     armv7l: 'c8cba0d82fa859d3dfd655e6cad0a4c012416bca1aa13dd83a8193bdedda2e7b',
       i686: '5885182a8479a6574eb740c64b1262a4ec32030f4e42e1a4da4edc57f716d8d7',
     x86_64: 'e8edb5350dcd31a4f32c3a9377e4cd119a98fbd727f5560fe4fd1c4215b05fad'
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
