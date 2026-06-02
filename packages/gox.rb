require 'package'

class Gox < Package
  description 'A dead simple, no frills Go cross compile tool.'
  homepage 'https://github.com/mitchellh/gox'
  version '1.0.1'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/mitchellh/gox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '686fb964bbcc9e4ecd9e54c7e2e0697f8b956ff0a72da51770d798888b7e153e',
     armv7l: '686fb964bbcc9e4ecd9e54c7e2e0697f8b956ff0a72da51770d798888b7e153e',
       i686: 'abf7a1af826d58ac36858b3d672c277674fbd98fdbb11562a91e8ce461fa8f94',
     x86_64: '3e5a08aaecf58d05a8140689ca095f7812fe992317902bd7d293aef625079afe'
  })

  depends_on 'go'

  def self.install
    system "go build -o #{CREW_DEST_PREFIX}/bin/gox"
  end
end
