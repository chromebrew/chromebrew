require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.9'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0dcf0c8db45500ccfdd043698ac606def418442a4f7787b67c6d582ac244766',
     armv7l: 'b0dcf0c8db45500ccfdd043698ac606def418442a4f7787b67c6d582ac244766',
       i686: 'd34d1adf34229245fa841bb657accccfa6ad9c9cf958dfd4285cedde87a738eb',
     x86_64: '0648b1bdda343e0226577caa1f33bb0a6fc88931adc6f9ad84cea92c8af50197'
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
