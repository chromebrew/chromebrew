require 'package'

class Volta < Package
  description 'JS Toolchains as Code'
  homepage 'https://volta.sh/'
  version '1.1.1'
  license 'BSD-2 Clause'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/volta-cli/volta/archive/v1.1.1.tar.gz'
  source_sha256 'f2289274538124984bebb09b0968c2821368d8a80d60b9615e4f999f6751366d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b1f8bffe3cc48eb31e8ee2c14aba862837195545be8156c596bf13af1eca006',
     armv7l: '2b1f8bffe3cc48eb31e8ee2c14aba862837195545be8156c596bf13af1eca006',
     x86_64: '3e26dda5ba2d6c66aaf284ac4e359f8d46e869892682d8294a3b942adc984b6f'
  })

  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/volta', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'target/release/volta-migrate', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'target/release/volta-shim', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
