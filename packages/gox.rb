require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.4.0'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/mitchellh/gox/archive/v0.4.0.tar.gz'
  source_sha256 '2df7439e9901877685ff4e6377de863c3c2ec4cde43d0ca631ff65d1b64774ad'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'bd18d1ee7da98692c0aaa53e9016d16a7a2cb5ecf07236c340a2613b6837f087',
     armv7l: 'bd18d1ee7da98692c0aaa53e9016d16a7a2cb5ecf07236c340a2613b6837f087',
       i686: '70e31b0602ad26369b711a0f740391d43cd297b4a5d16c4d1a04bdb843f99fb0',
     x86_64: 'd6d6c6c6d5aa168bea5c25a202c902d8b965040218a52291701c3e172d29c991'
  })

  depends_on 'go'

  def self.install
    system 'go get github.com/mitchellh/iochan'
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "go build -o #{CREW_DEST_PREFIX}/bin/gox"
  end
end
