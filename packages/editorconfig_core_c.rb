require 'buildsystems/cmake'

class Editorconfig_core_c < CMake
  description 'EditorConfig core code written in C for use by plugins supporting EditorConfig parsing'
  homepage 'https://github.com/editorconfig/editorconfig-core-c'
  version '0.12.11'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/editorconfig/editorconfig-core-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17f12a9eec13f8c6f7ec927d6debf9f6450548bd404299235066c5243e6e39da',
     armv7l: '17f12a9eec13f8c6f7ec927d6debf9f6450548bd404299235066c5243e6e39da',
       i686: 'bd70105f771307215d4fe417eb0f7aed3c8ff25c8b3fea44909265c0909d75bc',
     x86_64: '0c8ef401ae94449f9f8f64d19c3c9a09fcc8ecdd6e88851bab751d66a5d2b600'
  })

  depends_on 'glibc' => :library
  depends_on 'pcre2' => :library
end
