require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55278f86c7a788f857cd355038e7ee43a90fe5b1454653a397f25fbfadf8cb63',
     armv7l: '55278f86c7a788f857cd355038e7ee43a90fe5b1454653a397f25fbfadf8cb63',
       i686: '6c2cdc8a9f5a4e2d972041be2769e264e387a0cb027decdb602a957dcd30623c',
     x86_64: 'ceed36440e4945b4641efb26312c5bdb10fa3683b61b116d56e2f7a5c7f25b0a'
  })

  depends_on 'python3' => :build

  no_source_build
end
