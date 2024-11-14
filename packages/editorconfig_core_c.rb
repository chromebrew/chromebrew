# Adapted from Arch Linux editorconfig-core-c PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/editorconfig-core-c/trunk/PKGBUILD

require 'package'

class Editorconfig_core_c < Package
  description 'EditorConfig core code written in C for use by plugins supporting EditorConfig parsing'
  homepage 'https://github.com/editorconfig/editorconfig-core-c'
  version '0.12.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/editorconfig/editorconfig-core-c/archive/v0.12.6/editorconfig-core-c-0.12.6.tar.gz'
  source_sha256 '36052a5371731d915b53d9c7a24a11c4032585ccacb392ec9d58656eef4c0edf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e11a40cf379fbcdd7da6aa7183c097214909c6375bb609587a07fbeb55dd4eb3',
     armv7l: 'e11a40cf379fbcdd7da6aa7183c097214909c6375bb609587a07fbeb55dd4eb3',
       i686: 'b6f86925b01a0b25ff7fbac61fb6ca683e519ba262daf7a9a2389d7e79810a74',
     x86_64: 'eb1ad56f799f7f276aa7aef8a5d589a99b9f3469879eb79e2846f5c95dae22bd'
  })

  depends_on 'pcre2' # R
  depends_on 'doxygen' => :build
  depends_on 'glibc' # R

  def self.build
    system "mold -run cmake -B builddir \
          #{CREW_CMAKE_OPTIONS} \
          -Wdev \
          -G Ninja"
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
