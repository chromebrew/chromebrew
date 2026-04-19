require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.4.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '459d6b472eb99251302a18a29252b5f4848451c017826f87a17d3d2e0aaf59c6',
     armv7l: '459d6b472eb99251302a18a29252b5f4848451c017826f87a17d3d2e0aaf59c6',
     x86_64: 'fa39c67ebff03a231b33a00087c6ced2248848cf8c2432096781d4adbef717f3'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'pcre' => :build
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable
end
