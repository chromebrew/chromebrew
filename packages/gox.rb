require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.3.0-1'
  source_url 'https://github.com/mitchellh/gox/archive/v0.3.0.tar.gz'
  source_sha256 '29dc6b689f670a5444cc54cd9111549ccb01501901bc9197d0e1325a35157802'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c23c326ef0f69ac6b16273d127e4319a28804d88471823e4526c7ee136173a94',
     armv7l: 'c23c326ef0f69ac6b16273d127e4319a28804d88471823e4526c7ee136173a94',
       i686: '412a09bd66dadc623c40b324395655c4ebe06a0751e68daf5b403da9fa6b02f6',
     x86_64: 'fb0f4e74904b4b78ef739c921c0c8f7f329f537c9448002b00a494c5d2a13466',
  })

  depends_on 'go'

  def self.install
    system "go get github.com/mitchellh/iochan"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -o #{CREW_DEST_DIR}/usr/local/bin/gox"
  end
end
