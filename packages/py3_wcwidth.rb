require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5433381b6eace7917814c86518d5101fcad82adc4865e7ee4e0c99bd07e5a6ac',
     armv7l: '5433381b6eace7917814c86518d5101fcad82adc4865e7ee4e0c99bd07e5a6ac',
       i686: '5e4683a5c0f275e7016815d016ee2cb83c8dbd976f648dea09a3b19420f453bb',
     x86_64: '4bbaf470a8743c4ab0ba24e1bccdb4f55cd19db5df7a87e474f5dc6cc59935c3'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
