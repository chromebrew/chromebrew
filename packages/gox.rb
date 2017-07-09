require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '0.3.0-1'
  source_url 'https://github.com/mitchellh/gox/archive/v0.3.0.tar.gz'
  source_sha256 '29dc6b689f670a5444cc54cd9111549ccb01501901bc9197d0e1325a35157802'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gox-0.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gox-0.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gox-0.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gox-0.3.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf3bb36b821ad184486b3ef6601798ec07f6c853e329f98e99d6a1c808619121',
     armv7l: 'cf3bb36b821ad184486b3ef6601798ec07f6c853e329f98e99d6a1c808619121',
       i686: 'c385c8140a06503c5091565703f85b34d0f13f8ec65f71b64bd1ab614562b4f6',
     x86_64: '470499c914b8723cd76fe26b6ba1f7146b9b9005ca5469a73a621187cf724530',
  })

  depends_on 'go'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -o #{CREW_DEST_DIR}/usr/local/bin/gox"
  end
end
