require 'package'

class Imgur < Package
  description 'Upload images to Imgur via a small bash script.'
  homepage 'https://github.com/tremby/imgur.sh'
  version 'v9'
  compatibility 'all'
  source_url 'https://github.com/tremby/imgur.sh/archive/v9.tar.gz'
  source_sha256 '27283385658ea5223e6cb42de6a2486591c98d8adaeacf581b7f0a541d467645'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imgur-v9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imgur-v9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imgur-v9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imgur-v9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5052a66866c1b32f38124232b3472e545d6e180a4edce44bb9ec0c2dd396b1bf',
     armv7l: '5052a66866c1b32f38124232b3472e545d6e180a4edce44bb9ec0c2dd396b1bf',
       i686: '72d9323a5899f239a66045e472df1b404842381a34d38fe5391c39d6dc7d43ee',
     x86_64: 'eeebdb18fc194abe25f3c5c6e3782560be1771291f15316b047c1b357d60e10d',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp imgur.sh #{CREW_DEST_PREFIX}/bin/imgur"
  end
end
