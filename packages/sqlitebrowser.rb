require 'buildsystems/cmake'

class Sqlitebrowser < CMake
  description 'DB Browser for SQLite (DB4S) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite'
  homepage 'https://sqlitebrowser.org'
  version '3.13.1'
  license 'GPL-3 and MPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sqlitebrowser/sqlitebrowser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89a74626619181992c4f2871ca6aa50f1f601185d5298f2436ed4ef7c9569b98',
     armv7l: '89a74626619181992c4f2871ca6aa50f1f601185d5298f2436ed4ef7c9569b98',
       i686: '116f831ced1a81c4d2bd7dfc6fc29f31b6cbd2ca6101605cdcbab789bf155e31',
     x86_64: 'c18ec187150cdcedc2d25a82581f35b3316c48f0a03de1197d43ef27727e965d'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'qt5_base' => :executable
  depends_on 'qt5_tools' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'sqlite' => :logical

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
