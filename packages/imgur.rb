require 'package'

class Imgur < Package
  description 'Upload images to Imgur via a small bash script.'
  homepage 'https://github.com/tremby/imgur.sh'
  version '10.1'
  license 'unlicense'
  compatibility 'all'
  source_url 'https://github.com/tremby/imgur.sh.git'
  git_hashtag "v#{version}"

  no_compile_needed

  def self.install
    FileUtils.install 'imgur.sh', "#{CREW_DEST_PREFIX}/bin/imgur", mode: 0o755
  end
end
