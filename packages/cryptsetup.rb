require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.8.7'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v#{version.sub(/\.\d+$/, '')}/cryptsetup-#{version}.tar.xz"
  source_sha256 'e776f0d381e86ca61042c457069491fe8e0ac286780c7c3b1e4f9921abc961da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35a43ff3a863c5e5405d050d765797d6e2f2592a725eb8cba8d2fb10caea7894',
     armv7l: '35a43ff3a863c5e5405d050d765797d6e2f2592a725eb8cba8d2fb10caea7894',
       i686: '1696be692ab61f6a66cadd6a8fd38ff55197f5542dc86e1d4031fd7564681bb3',
     x86_64: 'b8b274191f932f18b4aaa9d60e18c862f93241168c932ed03cbc6312eadded09'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'json_c' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libssh' => :library
  depends_on 'lvm2' => :library
  depends_on 'openssl' => :library
  depends_on 'popt' => :executable
  depends_on 'util_linux' => :library

  autotools_configure_options '--disable-asciidoc'
end
