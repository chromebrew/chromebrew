require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.32'
  license 'BSD'
  compatibility 'all'
  source_url "http://www.catb.org/~esr/ascii/ascii-#{version}.tar.gz"
  source_sha256 '4a4d62bec25b3faea38b0a4ea2bc630e3393055c5f3ef197deee345de419b2a8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3b9efce0b5fef983da30aad96c294238bd37aff5b93630d79b0558276b216f5',
     armv7l: 'e3b9efce0b5fef983da30aad96c294238bd37aff5b93630d79b0558276b216f5',
       i686: 'ebb0d101a9dd33ff323b6cacc21eb7d5f6ec75e8465be9ef41b0dca8d9861557',
     x86_64: '8844ef50255fd938407da8d5927a019a711be792349342ec7f4767a4b8ecbff0'
  })

  depends_on 'asciidoctor' => :library
  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'ascii', "#{CREW_DEST_PREFIX}/bin/ascii", mode: 0o755
    FileUtils.install 'ascii.1', "#{CREW_DEST_MAN_PREFIX}/man1/ascii.1", mode: 0o644
  end
end
