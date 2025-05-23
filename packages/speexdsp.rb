require 'buildsystems/autotools'

class Speexdsp < Autotools
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/speexdsp.git'
  git_hashtag "SpeexDSP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8f5cad36ef6c75813de3ff755d1b2b5e03af07e4b5da6181b5a6bd679ec2e61',
     armv7l: 'e8f5cad36ef6c75813de3ff755d1b2b5e03af07e4b5da6181b5a6bd679ec2e61',
       i686: 'd3c27e8f73ecec0125695b2dbd1301e8dcc5092dd705104f150e51ba04089475',
     x86_64: '77dc391df3cfbf274e797b96b94f9217b9006b6a8f7acca19e33d39b83468397'
  })

  depends_on 'glibc' # R
  depends_on 'speex' # R

  autotools_configure_options '--disable-maintainer-mode \
      --disable-examples'
end
