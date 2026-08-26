require 'buildsystems/autotools'

class Xe < Autotools
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/leahneukirchen/xe'
  version '1.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/leahneukirchen/xe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c73139da82afefec7e73a35e7bb1af53297bc61f674ba10d81a825ae0f5c75f0',
     armv7l: 'c73139da82afefec7e73a35e7bb1af53297bc61f674ba10d81a825ae0f5c75f0',
       i686: '4b1c0540d41524ce2116610f236d334ab59a89c610124792a96c1213eb7c380e',
     x86_64: 'e6a0320b238198f8c21313d1a5e340f18130bf8ff0bbca910f187b216d556951'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure
end
