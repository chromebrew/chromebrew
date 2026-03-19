require 'buildsystems/cmake'

class Editorconfig_core_c < CMake
  description 'EditorConfig core code written in C for use by plugins supporting EditorConfig parsing'
  homepage 'https://github.com/editorconfig/editorconfig-core-c'
  version '0.12.10'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/editorconfig/editorconfig-core-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1bde9ba3e552ef6a455be6df84711c16983165cbf48c31b5511e922b954a4b6',
     armv7l: 'a1bde9ba3e552ef6a455be6df84711c16983165cbf48c31b5511e922b954a4b6',
       i686: 'beaf517a94f49555888861c2d41ba6858f89320727914bd0d96779cdc352602a',
     x86_64: '7cb97d683d99c0ea51799e2775ceb53e23efa78a9f25eb1513ca6bf6b1495253'
  })

  depends_on 'glibc' => :library
  depends_on 'pcre2' => :library
end
