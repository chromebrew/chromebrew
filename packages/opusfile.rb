# Adapted from Arch Linux opusfile PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opusfile/trunk/PKGBUILD

require 'buildsystems/cmake'

class Opusfile < CMake
  description 'Library for opening, seeking, and decoding .opus files'
  homepage 'https://opus-codec.org/'
  version '0.12-6dfd29e'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opusfile.git'
  git_hashtag '6dfd29e7adb87f2e193575fc3fa88cbf1a0b27df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '455238f0ece5d44c5ad2cc08c0ff552810c8281a1d3f6a0b4b0eb5e83724898f',
     armv7l: '455238f0ece5d44c5ad2cc08c0ff552810c8281a1d3f6a0b4b0eb5e83724898f',
       i686: '4bb34cb3e6d8dbbc333c01521302329671ee34f4c006f05a9a0a3d8674142056',
     x86_64: 'e29bf95fdbc4fd6e2a56fa465c393fd599b1e99809e9392aae94bee0f869c8dc'
  })

  depends_on 'glibc' => :library
  depends_on 'libogg' => :library
  depends_on 'openssl' => :library
  depends_on 'opus' => :library

  git_fetchtags

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_build_extras do
    # Needed to generate opusfile.pc
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX}"
  end

  cmake_install_extras do
    FileUtils.install 'opusfile.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/opusfile.pc", mode: 0o644
  end
end
