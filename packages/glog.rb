require 'buildsystems/cmake'

class Glog < CMake
  description 'A C++ implementation of the Google logging module.'
  homepage 'https://github.com/google/glog'
  version '0.7.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/google/glog.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c07ece254b3993f76859a9dd526fc27a74e6f93fa15703afdb7923ce51ec994f',
     armv7l: 'c07ece254b3993f76859a9dd526fc27a74e6f93fa15703afdb7923ce51ec994f',
       i686: '74b692b165ed385418b6a5e426404f3e0b7ae95dc3615358c5db6cc49aea8a07',
     x86_64: 'ada23d70ad1f16e1aeb701cf76ea0c12bcbe932f7cc92bd66f8d3e99a16a01db'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gflags' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libunwind' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF'
end
