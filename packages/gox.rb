require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.3.0-1'
  source_url 'https://github.com/mitchellh/gox/archive/v0.3.0.tar.gz'
  source_sha256 '29dc6b689f670a5444cc54cd9111549ccb01501901bc9197d0e1325a35157802'

  depends_on 'go'

  def self.install
    system "go get github.com/mitchellh/iochan"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -o #{CREW_DEST_DIR}/usr/local/bin/gox"
  end
end
