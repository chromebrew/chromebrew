require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '762f6ee8a11e4299e869bf9aa03b697adc3cde58d2268b074339c9c181aeaa87',
     armv7l: '762f6ee8a11e4299e869bf9aa03b697adc3cde58d2268b074339c9c181aeaa87',
       i686: '53957a47c0ab8b9de69b6f63ac86a3636a87351471c18ef306c9da473bbf8fe1',
     x86_64: 'd91824c133f8c42bce123ba9411d0a62565a38d0647bf9167e256d3ec9b5c41f'
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
