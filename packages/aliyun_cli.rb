require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.5.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aedaf1fd0b97f1dc255d7088bec439b5a7cd140be5493bb62111cddfef5e6d93',
     armv7l: 'aedaf1fd0b97f1dc255d7088bec439b5a7cd140be5493bb62111cddfef5e6d93',
       i686: 'e79aa0733c9b5bba701e7d5c61d431f16022d637bbea0bd2f1649c9be0f12be9',
     x86_64: '32ff67c7f99118484d8610b8eab538dff12dce28c18e2a7415ad5906638163f9'
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
