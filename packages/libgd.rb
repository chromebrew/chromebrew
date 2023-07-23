require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.org/'
  version '2.3.3'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/libgd/libgd.git'
  git_hashtag "gd-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgd/2.3.3_armv7l/libgd-2.3.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgd/2.3.3_armv7l/libgd-2.3.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgd/2.3.3_i686/libgd-2.3.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgd/2.3.3_x86_64/libgd-2.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7cf782cc8aec78168810faa2b83f66edc791820f13e6a0ffdd45c33ff7c034e9',
     armv7l: '7cf782cc8aec78168810faa2b83f66edc791820f13e6a0ffdd45c33ff7c034e9',
       i686: '1e8ec5a47547e2cd484b45b7bb0cff89f7049f5841ebdc85d852b9bb02ad45bb',
     x86_64: '0e6c97f3a19ad37591c1dd8b1daa44fa34661130282ca50a697f1ab01f080a64'
  })

  depends_on 'libpng' => :build
  depends_on 'libavif' => :build
  depends_on 'libheif' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "mold -run cmake -B builddir \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_INCLUDE_PATH=#{CREW_PREFIX}/include"
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
