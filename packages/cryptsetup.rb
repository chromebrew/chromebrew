require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.7.3'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v2.7/cryptsetup-2.7.3.tar.xz'
  source_sha256 'b772ae4f6df0cee7200b28cea960e4daaff2a203d2fd502beab3c1317b07a456'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a48fd6d1484d347870e919a53a0de9700ccb8f01994acca02bc8b00448e585e',
     armv7l: '0a48fd6d1484d347870e919a53a0de9700ccb8f01994acca02bc8b00448e585e',
       i686: '8b14383a9cadf16697e12eafea51ef990e8a7e03018becb2ee814cb79d626ab5',
     x86_64: '47cd09d893cfd85342ecac90a564396743e209f53ebed70aee9fd94d6bdb19ed'
  })

  depends_on 'lvm2'
  depends_on 'json_c'
  depends_on 'libgcrypt'
  depends_on 'popt'

  autotools_configure_options '--disable-asciidoc'
end
