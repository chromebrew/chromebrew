require 'package'

class Imgur < Package
  description 'Upload images to Imgur via a small bash script.'
  homepage 'https://github.com/tremby/imgur.sh'
  version 'v9'
  source_url 'https://github.com/tremby/imgur.sh/archive/v9.tar.gz'
  source_sha256 '27283385658ea5223e6cb42de6a2486591c98d8adaeacf581b7f0a541d467645'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp imgur.sh #{CREW_DEST_PREFIX}/bin/imgur"
  end
end
