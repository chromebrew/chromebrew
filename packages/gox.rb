require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.4.0'
  source_url 'https://github.com/mitchellh/gox/archive/v0.4.0.tar.gz'
  source_sha256 '2df7439e9901877685ff4e6377de863c3c2ec4cde43d0ca631ff65d1b64774ad'

  depends_on 'go'

  def self.install
    system "go get github.com/mitchellh/iochan"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -o #{CREW_DEST_DIR}/usr/local/bin/gox"
  end
end
