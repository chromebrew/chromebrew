require 'buildsystems/cmake'

class Libmaxminddb < CMake
  description 'C library for the MaxMind DB file format.'
  homepage 'https://maxmind.github.io/libmaxminddb/'
  version '1.11.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/maxmind/libmaxminddb.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9317f59be14aa2d07e3d02ff2e00bdbd48fa47c5f93d6a0264730dd194cefec7',
     armv7l: '9317f59be14aa2d07e3d02ff2e00bdbd48fa47c5f93d6a0264730dd194cefec7',
       i686: '0fc6795d757ee451a0a16f5c4254d2de282bdde92818fb1ab98fd21867a577c1',
     x86_64: 'f35e028343a26c60c3a93a6938925d8549e7614f13166795566196e8ef3745e8'
  })

  depends_on 'glibc' # R

  run_tests

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
