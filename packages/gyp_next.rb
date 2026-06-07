require 'buildsystems/python'

class Gyp_next < Python
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.22.2'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '656648167d6aef5207d10fb6d1034f14ad03366f4548eb709fe67a4e335ae721',
     armv7l: '656648167d6aef5207d10fb6d1034f14ad03366f4548eb709fe67a4e335ae721',
       i686: 'c2dd2182895244cac1b2aa0e0a04be47274c8821a01dee50435f8a6c742af7c8',
     x86_64: 'ae7feba700a457fed6769d588576619fa1f1b787f13c57c54b28a2a12a5e5f72'
  })

  depends_on 'python3' => :logical

  def self.postinstall
    ExitMessage.add "\nType 'gyp -h' to get started.\n"
  end
end
