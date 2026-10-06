require 'buildsystems/meson'

class Radare2 < Meson
  description 'unix-like reverse engineering framework and commandline tools'
  homepage 'https://www.radare.org/r/'
  version '6.2.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/radare/radare2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33cad798f3a960c37f438bb7842d6f921ac718d74d039a2402f97e92f5bdab20',
     armv7l: '33cad798f3a960c37f438bb7842d6f921ac718d74d039a2402f97e92f5bdab20',
       i686: '6cd5a887c740f690fe7740b03a7d814e20c1d352b3ca30d1a388c56f76e801e0',
     x86_64: 'f8cd5c4506471ceeb8c73337bbbffaf4601818742c7e388266edb1a67758dadf'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl'

  meson_options '-Duse_sys_openssl=true'
end
