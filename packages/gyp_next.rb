require 'buildsystems/python'

class Gyp_next < Python
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.22.4'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f6e759fea4925216f096ae000f891d651593469977c5796e74af39647dac728',
     armv7l: '8f6e759fea4925216f096ae000f891d651593469977c5796e74af39647dac728',
       i686: '87640481e0e697f167115e594c8f8dcb507d9598c2a56bf56952a6f326f80f95',
     x86_64: 'a6ce4607067e37759d33bd0a5263eb17deb8d99520989c7d65411184c2146e2e'
  })

  depends_on 'python3' => :logical

  def self.postinstall
    ExitMessage.add "\nType 'gyp -h' to get started.\n"
  end
end
