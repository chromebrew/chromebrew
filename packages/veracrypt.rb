require 'package'

class Veracrypt < Package
  description 'VeraCrypt is a free open source disk encryption software for Windows, Mac OSX and Linux.'
  homepage 'https://www.veracrypt.fr/en/Home.html'
  version '1.25.9'
  license 'Apache 2.0 and TrueCrypt 3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://www.veracrypt.fr/code/VeraCrypt/snapshot/VeraCrypt_1.25.9.tar.gz'
  source_sha256 '66f2195f126df53f1037cc4b81ea4b9eaa5cd6aaa351f5cfe324760fdefab0d0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '110caf9f2d53edb107d94ab8a45d08014f6fd93f54e3f4f8f5fef6bebb809229',
     armv7l: '110caf9f2d53edb107d94ab8a45d08014f6fd93f54e3f4f8f5fef6bebb809229',
     x86_64: '6ffd9a70f7161d662a2db6427ed52753836e780386f3171bd8b308ba2b7f72f1'
  })

  depends_on 'yasm' => :build
  depends_on 'fuse2'
  depends_on 'wxwidgets31'

  def self.build
    Dir.chdir 'src' do
      system 'make'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'src/Main/veracrypt', "#{CREW_DEST_PREFIX}/bin/veracrypt", mode: 0o755
  end
end
