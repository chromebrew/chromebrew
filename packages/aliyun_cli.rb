require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.4.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd70aa7369691bc148c03add0479829e3a656d4fc57bd060195092cee3a57ec4',
     armv7l: 'fd70aa7369691bc148c03add0479829e3a656d4fc57bd060195092cee3a57ec4',
       i686: '4e4d95e6eb56be2fc76152ce2d1b448e90dfbe64e7f674891bfdabb95124978a',
     x86_64: 'a33d169cebdf001794e212239c0e6088761a12b8d93bb17903ec947e1099218d'
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
