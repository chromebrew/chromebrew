require 'package'

class Pigz < Package
  description 'A parallel implementation of gzip for modern multi-processor, multi-core machines'
  homepage 'https://zlib.net/pigz/'
  version '2.8'
  license 'ZLIB'
  compatibility 'all'
  source_url "https://zlib.net/pigz/pigz-#{version}.tar.gz"
  source_sha256 'eb872b4f0e1f0ebe59c9f7bd8c506c4204893ba6a8492de31df416f0d5170fd0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4367672f7ea6833e0098fe4cec1f57ea57e7013c441b03017631def5fc774f19',
     armv7l: '4367672f7ea6833e0098fe4cec1f57ea57e7013c441b03017631def5fc774f19',
       i686: '87130e9f6b588e86ef968cc3770df7ca26245ce8a3b287532a9ab871fee62fb2',
     x86_64: '31bc09206e5584d32ebd36ad3f71199c6673205003145cb07039f2c0579c44a1'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'zlib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'pigz', "#{CREW_DEST_PREFIX}/bin/pigz", mode: 0o755
    FileUtils.install 'unpigz', "#{CREW_DEST_PREFIX}/bin/unpigz", mode: 0o755
    FileUtils.install 'pigz.1', "#{CREW_DEST_MAN_PREFIX}/man1/pigz.1", mode: 0o644
  end
end
