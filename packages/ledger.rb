require 'buildsystems/cmake'

class Ledger < CMake
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://ledger-cli.org/'
  version '3.4.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ledger/ledger.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '566d5cd7eb8041322e82f6175a3e1f87d4bbff5fcef68b0c7eafbca4992e4edd',
     armv7l: '566d5cd7eb8041322e82f6175a3e1f87d4bbff5fcef68b0c7eafbca4992e4edd',
     x86_64: '564ac4adf3b2b1e13d489daadec59ddd97a054dea8a622d8fc07f16696ae6a2d'
  })

  depends_on 'boost' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gmp' => :library
  depends_on 'libedit' => :library
  depends_on 'mpfr' => :library
end
