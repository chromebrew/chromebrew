require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.0.284'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7a970329f5f13c3d39fc359ab54c6b7bf686ba667c448d880116bb0be0b1770',
     armv7l: 'c7a970329f5f13c3d39fc359ab54c6b7bf686ba667c448d880116bb0be0b1770',
       i686: 'b49ad1682730316ae9ea6372e223e9ec956625647fddf7a98b69d11fc94117f1',
     x86_64: '193916dd7e7c9604ebab5d4f7c3e4d9782bf5342f6eda7a53f6e20c41b70e126'
  })

  depends_on 'go' => :build
  depends_on 'glibc' # R

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
