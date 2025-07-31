require 'buildsystems/cmake'

class Check < CMake
  description 'A unit testing framework for C'
  homepage 'https://libcheck.github.io/check/'
  version '0.15.2-1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/libcheck/check.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '935119bc79d705b92a3a67d422b86aa466284bc907026635c06b1767ca1bf346',
     armv7l: '935119bc79d705b92a3a67d422b86aa466284bc907026635c06b1767ca1bf346',
       i686: 'f248bc49996c8a5778574cb899647f493b5411c2ce829f96b899c9233de91927',
     x86_64: '7dc419c3be381ccf3575554bbd8e9d4ddd6cc38ede64c29d9b0922ab86d4624a'
  })

  depends_on 'glibc' # R

  cmake_options '-DCHECK_ENABLE_TIMEOUT_TESTS=OFF'
end
