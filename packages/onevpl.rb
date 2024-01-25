# Adapted from Arch Linux onevpl PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=onevpl

require 'package'

class Onevpl < Package
  description 'oneAPI Video Processing Library'
  homepage 'https://www.intel.com/content/www/us/en/developer/tools/oneapi/onevpl.html'
  version '2023.1.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/oneapi-src/oneVPL/archive/refs/tags/v2023.1.0.tar.gz'
  source_sha256 '0a1991278c64849f471e4b307a7c01f465a308674f359054886c32352e887b60'
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'ad119dc97568f728a42b909a6c3980d9245fc10fa81bab64a261e3c8c6e6d634'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'intel_media_sdk' # R
  depends_on 'libdrm' # R
  depends_on 'libva' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTS:BOOL='OFF' \
        -DINSTALL_EXAMPLE_CODE:BOOL='OFF' \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
