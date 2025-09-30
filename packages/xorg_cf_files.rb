require 'buildsystems/meson'

class Xorg_cf_files < Meson
  description 'X.org cf files for use with imake builds.'
  homepage 'https://x.org/wiki/'
  version '1.0.9'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.x.org/releases/individual/util/xorg-cf-files-#{version}.tar.xz"
  source_sha256 '07716eb1fe1fd1f8a1d6588457db0101cae70cb896d49dc65978c97b148ce976'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '499caa33db07d282c6341ee7f1c2742e77e6f6dc96f34076113308465a0876d5',
     armv7l: '499caa33db07d282c6341ee7f1c2742e77e6f6dc96f34076113308465a0876d5',
       i686: '09dcc02c379e107d7f4aa327bf9821cc3ed7525982d6f1ed8faafd934864972e',
     x86_64: '65c4d1f4e862b16ab6be04e53232ff37757a3c7cb8ee889e538d2181cf986c33'
  })

  depends_on 'font_util' => :build
end
