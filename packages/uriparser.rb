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
    aarch64: 'd777e9616e5e3ce9688212c956b494c3250aa292bd9823e2d970bfd2cff527d5',
     armv7l: 'd777e9616e5e3ce9688212c956b494c3250aa292bd9823e2d970bfd2cff527d5',
       i686: 'd7d7a7e85dc2209b16c024508b87cb5a29fa0736d3b0c69166aca26daf168512',
     x86_64: '61ac0d35cc2748bd781e651d7d5d7f0a0643e11afaaa5e2069b889a5ce3f739c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF \
    -DURIPARSER_BUILD_TESTS=OFF'

  def self.patch
    patches = [
      ['https://github.com/uriparser/uriparser/pull/316.diff', 'ae7f8880a6e7206a5e6492550217493c3b3a7e9e45e4f1d9c263870857dbe4b8']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
