require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.3.0'
  source_url 'https://github.com/mitchellh/gox/archive/v0.3.0.tar.gz'
  source_sha256 '29dc6b689f670a5444cc54cd9111549ccb01501901bc9197d0e1325a35157802'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gox-0.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fe6431f046bae54f6e7753cd2cf0c4f85087a004927da65845e184b82c54ab37',
     armv7l: 'fe6431f046bae54f6e7753cd2cf0c4f85087a004927da65845e184b82c54ab37',
       i686: '07f529c6d0ef5cd84d21a4ad37c370070d88bee02940ab5e9186ef1645bc513a',
     x86_64: '7d43be449836eac9aaf368bbba2bd8571489a2cdeae1999ab7ac19d1d9a84d97',
  })

  depends_on 'go'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -o #{CREW_DEST_DIR}/usr/local/bin/gox"
  end
end
