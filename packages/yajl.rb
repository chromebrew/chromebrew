require 'buildsystems/cmake'

class Yajl < CMake
  description 'A fast streaming JSON parsing library in C.'
  homepage 'https://lloyd.github.io/yajl/'
  version '2.1.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/lloyd/yajl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f63880f74807f1934ed2661599e13fdc9f01766e385b58826a1e1b8f9a0402a',
     armv7l: '7f63880f74807f1934ed2661599e13fdc9f01766e385b58826a1e1b8f9a0402a',
       i686: 'cdadc9f56f29b9d171c9adda2286339836dcc7ef5acaec1093db93c11ade7491',
     x86_64: '1a57f6807cbcc7a96a5b480b891628534048d62b4d1f44efd986f8b2144a573f'
  })

  depends_on 'glibc' # R

  def self.patch
    patches = [
      # Fix for CVE-2017-16516
      ['https://github.com/rtobar/yajl/commit/29776e34c226988935f4eb82991c611ba8b153b9.patch', '423847f4e448361cae1d86a2ab62e47b3cd31b76a065294ff9b2e5a689ec9cbd'],
      # Fix for CVE-2022-24795
      ['https://github.com/rtobar/yajl/commit/9fd851460dde6655f19f17bf551dcef125102a4c.patch', '6c22ba6f858094601b48fda15d550effc352bfe4ce20c189fc743077ce8b1ce0'],
      # Fix for CVE-2023-33460a
      ['https://github.com/rtobar/yajl/commit/1db6a0345c59970c4a647c0df00d0d5cbfd42fe3.patch', '93cd4b535eee6a9a8539d78c05c0283ca63eb3a07d2c9a70b42412d1a72eec1b'],
      # Fixes incorrect lower bound for integers (#130)
      ['https://patch-diff.githubusercontent.com/raw/lloyd/yajl/pull/251.patch', '24b6928e87f388f633b51b98025c15ca6cd40c4cd388278cbb98bd06c64be719']
    ]
    ConvenienceFunctions.patch(patches)
  end

  cmake_options "-DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"
end
