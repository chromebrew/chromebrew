require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.2.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a9d2272385f03521857621cd5a20c2049b3b512e7602ee91d12d544823c9127',
     armv7l: '4a9d2272385f03521857621cd5a20c2049b3b512e7602ee91d12d544823c9127',
       i686: '1fd4021f5e1651233c106ca02a7a7ed9366ad578868d84d1b3bd818d308555e4',
     x86_64: 'c717c8daf2e152d1966fe76bdbc93d8830c1b82fad9e93da478b3c0002215538'
  })

  depends_on 'glibc' => :executable_only
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
