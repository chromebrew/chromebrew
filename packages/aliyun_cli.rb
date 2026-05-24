require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.16'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37a84eb481b8315f9d300347fd50b9c0f1dc0dd8e8e38ea940358320416987b3',
     armv7l: '37a84eb481b8315f9d300347fd50b9c0f1dc0dd8e8e38ea940358320416987b3',
       i686: '552d579f69f136cfe0b308c5229cbcbcb0b08c007743e426fb9580ea0d673ffa',
     x86_64: '56cb9486202bfe5750c05d24b31cf3a614b5df1b0575101213e52dbc7dfdf126'
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
