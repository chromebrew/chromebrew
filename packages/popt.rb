require 'buildsystems/autotools'

class Popt < Autotools
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.19'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rpm-software-management/popt.git'
  git_hashtag "popt-#{version}-release"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebc6b6cbbda56703184a89256b65e876a4343a5d123f30ea75b37b7455840b5b',
     armv7l: 'ebc6b6cbbda56703184a89256b65e876a4343a5d123f30ea75b37b7455840b5b',
       i686: '5f1177c7e43be724bfd13f191f66df606839dc7050fab747bf4a0faf119036ad',
     x86_64: 'ef8d69f383a22b36318ce097b0f953a0dd318dffa174acf645b0ac1342e346e1'
  })

  depends_on 'glibc' # R
end
