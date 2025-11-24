require 'buildsystems/cmake'

class Slop < CMake
  description 'slop (Select Operation) is an application that queries for a selection from the user and prints the region to stdout.'
  homepage 'https://github.com/naelstrof/slop'
  version '7.7'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/naelstrof/slop.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfd1ed7d3816b99f60a6ef3f3123d5ba47be373058b323e8ba4209467b45e1c4',
     armv7l: 'cfd1ed7d3816b99f60a6ef3f3123d5ba47be373058b323e8ba4209467b45e1c4',
     x86_64: '07bc9eab905361ffe881aa8cfd7e3349ab2fa7b33be850b31f676a54d9e66e33'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glew'
  depends_on 'glibc' # R
  depends_on 'glm'
  depends_on 'icu4c' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11'
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'mesa_utils' # R
end
