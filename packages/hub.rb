require 'package'

class Hub < Package
  description 'hub is a command-line wrapper for git that makes you better at GitHub.'
  homepage 'https://hub.github.com/'
  version '2.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/github/hub/archive/refs/tags/v2.14.2.tar.gz'
  source_sha256 'e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a'

  depends_on 'go' => :build

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "script/build -o #{CREW_DEST_PREFIX}/bin/hub"
  end
end
