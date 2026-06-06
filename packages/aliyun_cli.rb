require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.22'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25f84353c34267e76bc51208f09027e97a088927c99a9d3c4fe8ed4f85811eca',
     armv7l: '25f84353c34267e76bc51208f09027e97a088927c99a9d3c4fe8ed4f85811eca',
       i686: '567b0878d8e48d4312ef28f654e1448731499ac88d160d00bf36d4a4e331e3f7',
     x86_64: 'c8e0789cce86cbfcc0bb6da49fb8dbb3ca6c9011931b2edb92c8dbf2ea083aaa'
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
