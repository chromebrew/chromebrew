require 'buildsystems/cmake'

class Agedu < CMake
  description 'Unix utility for tracking down wasted disk space'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/'
  version '20260410.3622eda'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url "https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-#{version}.tar.gz"
  source_sha256 '37be3c0de116b4fa44d390cca929248fd2e12586ef22aca9474a009c568e561c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '108c293a11d76668616ad5c94e7dfa0d540ea0f7b34348d2168d0923ddb681be',
     armv7l: '108c293a11d76668616ad5c94e7dfa0d540ea0f7b34348d2168d0923ddb681be',
       i686: 'bc718988f578d8fb55ba7d06907810779e0d31270e6f2cb53d261bc5f62d0eef',
     x86_64: '2746f953394dd87e80d173f6a43463cd63aafe36f1586c338ccf56c5d455488e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
