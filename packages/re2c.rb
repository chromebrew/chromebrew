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
    aarch64: '3d84b8101c4433a614603b3ec428f525fab04c3a84798b9bd769a789b994a76e',
     armv7l: '3d84b8101c4433a614603b3ec428f525fab04c3a84798b9bd769a789b994a76e',
       i686: '25b5046a6afe1f48da7a1d91cba641defd388873c66d8115b605f91b7bde4fff',
     x86_64: 'bb20f18817aab59c828bdc88da1e630ce8f2fc9f796db974309be077501f3009'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
