require 'buildsystems/python'

class Gyp_next < Python
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.22.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff455280f69792e6cf1f78dc9071766ddff2ce36fc2d9cce1e364990e7b85633',
     armv7l: 'ff455280f69792e6cf1f78dc9071766ddff2ce36fc2d9cce1e364990e7b85633',
       i686: 'dbc8db0adffc306ae58d780fe42a15273b2f5443a6d9690d069f113cde6223b4',
     x86_64: '452e033155b71373bf5dfec2b21bc644a1794f2498f8fb61ade7f41b3542b26b'
  })

  depends_on 'python3' => :logical

  def self.postinstall
    ExitMessage.add "\nType 'gyp -h' to get started.\n"
  end
end
