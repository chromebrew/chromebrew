require 'package'

class Aliyun_cli < Package
  description 'Alibaba Cloud CLI'
  homepage 'https://www.alibabacloud.com/help/en/cli/'
  version '3.3.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aliyun/aliyun-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e51a3906b685dc7bca277419774dcc7fb61aeb3ce326f74db39b87b20288d44c',
     armv7l: 'e51a3906b685dc7bca277419774dcc7fb61aeb3ce326f74db39b87b20288d44c',
       i686: '71627225cece55c2dad2effe2cf5be8e7804591c67569374869652fdbf3a3c4c',
     x86_64: 'ac2e652b899971edc44f8462cf4ebdb870b9127f5688e786ef4cecd2b6183ffa'
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
