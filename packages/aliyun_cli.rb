require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.5.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eba5936d373aeadf55e0cb619438a07deeab42667c4370e5b454ca34f77c4592',
     armv7l: 'eba5936d373aeadf55e0cb619438a07deeab42667c4370e5b454ca34f77c4592',
       i686: '3dfd9b4cabc6dc72c037ef1e4050b5c05bbf37802910b4e5adabdb909378fe0a',
     x86_64: 'e59ccd55677cd601c4e1021d222dab5ab5888f463f9c8de232976aa7a3774e13'
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
