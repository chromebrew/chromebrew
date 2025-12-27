require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d2bcf2b5136fd3601fc2197c77b0acd2e06cad764fd837844ab162c28277cfd',
     armv7l: '4d2bcf2b5136fd3601fc2197c77b0acd2e06cad764fd837844ab162c28277cfd',
       i686: '0f78da57b9d07efc42814b408b6886aaab8b553cdd1f3f46dd861f918e207a78',
     x86_64: '1d70cecf70b0fdca714cf2a25f5aeeb577e86cd7bed3f95b3735b8c14735c14f'
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
