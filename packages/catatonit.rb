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
    aarch64: '6bb468c2e667f596401cfdbdb39fdac06bbf016e53bd6fd24c27513e1ea2742a',
     armv7l: '6bb468c2e667f596401cfdbdb39fdac06bbf016e53bd6fd24c27513e1ea2742a',
       i686: '0626cda2e2df48b894e6479be6608572de3cf70cb051094f0a78f284007341d4',
     x86_64: '32d504ee383cd9fdd777877f8c5aed7832264673693db459ed659346b83dc5ce'
  })
end
