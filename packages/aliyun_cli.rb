require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.1.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39830f98469b7dd5e0e6a247c58d18f7ae9ef4c8615141367544f1a9ed4dd8b2',
     armv7l: '39830f98469b7dd5e0e6a247c58d18f7ae9ef4c8615141367544f1a9ed4dd8b2',
       i686: '7db2cc5bfa6de9997aa8a3ffc3954299b2df26fbd97b7e21e0dc853ebbfc080f',
     x86_64: '7189edc3967ca129c30705f7a2ffebc74f37a2793969d1cee671e98ff9de9c8b'
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
