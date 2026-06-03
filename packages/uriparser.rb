require 'buildsystems/cmake'

class Uriparser < CMake
  description 'uriparser is a strictly RFC 3986 compliant URI parsing library. uriparser is cross-platform, fast, supports Unicode'
  homepage 'https://github.com/uriparser/uriparser'
  version '1.0.2'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url 'https://github.com/uriparser/uriparser.git'
  git_hashtag "uriparser-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c5e487a16d9f039f16ef94210342a6dfadd24e4c91775ce5207718890cb7127',
     armv7l: '0c5e487a16d9f039f16ef94210342a6dfadd24e4c91775ce5207718890cb7127',
     x86_64: '6d588afa003c86a827127f1e62761775bebf361a83247726bad57df3d839e543'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF \
    -DURIPARSER_BUILD_TESTS=OFF'

  def self.patch
    patches = [
      ['https://github.com/uriparser/uriparser/pull/316.diff', 'ae7f8880a6e7206a5e6492550217493c3b3a7e9e45e4f1d9c263870857dbe4b8'],
    ]
    ConvenienceFunctions.patch(patches)
  end

end
