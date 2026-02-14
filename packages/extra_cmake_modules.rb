require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.23.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d0f482bfac75d23b32cdbf46e22280ce24ebcc106269c7b1efb344ee56dd6ff',
     armv7l: '2d0f482bfac75d23b32cdbf46e22280ce24ebcc106269c7b1efb344ee56dd6ff',
       i686: '30b9b608a3cd09d1be82f4bf608f7f4a857e39b8b65b7e92053a185af0ef7d11',
     x86_64: 'f3e3010c20b446a4bbcf7d39640f0bca10eae909dbe21fc079d35dee7e49d1eb'
  })

  depends_on 'sphinx' => :build
end
