require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.14'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acd6accca02d5ba1056b7a81b88dbf54e62e9cbe5e6950905c42a7761a31b44c',
     armv7l: 'acd6accca02d5ba1056b7a81b88dbf54e62e9cbe5e6950905c42a7761a31b44c',
       i686: '01b60b507011bb5f21b32209d1ce238c7606db35fcb48bff25b8315854a4aba9',
     x86_64: 'fed56b42b85e5ade164d42cb86cdc1c55d9b4a18a0152eacc5945ad61cf07826'
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
