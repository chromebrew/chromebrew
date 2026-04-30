require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79398826c5661accc293ac73ef2d2f83b1714c3b237eac85347bb9e977cb22ac',
     armv7l: '79398826c5661accc293ac73ef2d2f83b1714c3b237eac85347bb9e977cb22ac',
       i686: '3acf42e9373bd422933864b337b296c1fd62d163a34c0d394153301e81da62fd',
     x86_64: '416ddf9e9ad461374a5aa16d19c91834fd12ebc8956d32b3fa83a0c6a8a81931'
  })

  depends_on 'glibc' => :executable
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
