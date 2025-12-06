require 'buildsystems/autotools'

class Catatonit < Autotools
  description 'A container init that is so simple its effectively brain-dead.'
  homepage 'https://github.com/openSUSE/catatonit/'
  version '0.2.1'
  license 'GPL3'
  compatibility 'all'
  source_url "https://github.com/openSUSE/catatonit/releases/download/v#{version}/catatonit.tar.xz"
  source_sha256 '9950425501af862e12f618bdc930ea755c46db6a16072a1462b4fc93b2bd59bc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e53312d2dfe70cb4983c842faa39bbfbec1482057669e98d2a3920203182c944',
     armv7l: 'e53312d2dfe70cb4983c842faa39bbfbec1482057669e98d2a3920203182c944',
       i686: '236251e20bb00af261ac86787ae40db52d54e99b4c1007a294d2f1e353e174b7',
     x86_64: '56ce55a9a73f365b7d46577b7ee0df920a45a541a97c15a155c3037a5d534ebf'
  })
end
