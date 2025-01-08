require 'buildsystems/autotools'

class Sshpass < Autotools
  description 'Tool for non-interactivly performing password authentication'
  homepage 'https://sourceforge.net/projects/sshpass/'
  version '1.10'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/sshpass/sshpass/#{version}/sshpass-#{version}.tar.gz"
  source_sha256 'ad1106c203cbb56185ca3bad8c6ccafca3b4064696194da879f81c8d7bdfeeda'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f2431ab17af5f0a13187fa6d6d568cbee45bab6fafd239642ddadedf1e1c9ec',
     armv7l: '9f2431ab17af5f0a13187fa6d6d568cbee45bab6fafd239642ddadedf1e1c9ec',
       i686: 'a3b6bd7ad0e863608e781b8734c326406eeb46048e2e23c7603fcd295ab92f64',
     x86_64: '7ac826922ae01f0a82082e545bc30e306b1e4b146f9839a235ec025f5e903fce'
  })

  depends_on 'glibc' # R
end
