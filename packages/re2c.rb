require 'buildsystems/cmake'

class Re2c < CMake
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '4.6'
  license 'public-domain'
  compatibility 'all'
  source_url "https://github.com/skvadrik/re2c/releases/download/#{version}/re2c-#{version}.tar.lz"
  source_sha256 'c002a864734bec2899cc95e2db2aba4f63104bece866f3631a6ed93be2ca7be9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e886a5c5b32dc51fabf77af86a9247b1f59684490a1fb61fa669941253bc54f',
     armv7l: '6e886a5c5b32dc51fabf77af86a9247b1f59684490a1fb61fa669941253bc54f',
       i686: 'f0963a657de299ee4b28b8bf24420e6ab9c53a2607123c025e29f29a04e391f8',
     x86_64: '9f60169e9c8621b036cad0769eb6b9e9b099bc2cdcdd7b447288e5b2f5dc9dff'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
