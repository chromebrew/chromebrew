require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.3.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c48b84a284a041ca31c74bb13ee9b74d5637bbd65fef3c152a87e7f63a81da70',
     armv7l: 'c48b84a284a041ca31c74bb13ee9b74d5637bbd65fef3c152a87e7f63a81da70',
       i686: '1c07e974483808095cc3e42155f3bda84e84f5dcaadfa67fc388aaab7d424a19',
     x86_64: 'b703ed720a781b0d325625b64b7d65ab9617715ff213e0452586a5c0bd27bd31'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre' => :build
  depends_on 'pcre2' # R
  depends_on 'zlib' # R
end
