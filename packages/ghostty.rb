# Adapted from Arch Linux ghostty PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ghostty

require 'package'

class Ghostty < Package
  description 'Fast, native, feature-rich terminal emulator pushing modern features'
  homepage 'https://ghostty.org'
  version '1.1.3'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://release.files.ghostty.org/#{version}/ghostty-source.tar.gz"
  source_sha256 '51dd34e68d3eac61beff8e12db0068790678778b81208bb4d626fa59e9ff171a'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '661c109215c98b34ae7dff4c52634e4ebb3f1c8adfcad398d9347e9becaab34f'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'libx11' # R
  depends_on 'oniguruma' # R
  depends_on 'pandoc' => :build
  depends_on 'wayland' # R
  depends_on 'zig13' => :build

  def self.patch
    system "sed -i 's/linkSystemLibrary2(\"bzip2\", dynamic_link_opts)/linkSystemLibrary2(\"bz2\", dynamic_link_opts)/' src/build/SharedDeps.zig"
  end

  def self.build
    @zig_global_cache_dir = "#{`pwd`.chomp}/offline-cache"
    FileUtils.mkdir_p @zig_global_cache_dir
    system "ZIG_GLOBAL_CACHE_DIR=#{@zig_global_cache_dir} ./nix/build-support/fetch-zig-cache.sh"
    system "DESTDIR=build zig build \
      --summary all \
      -p #{CREW_PREFIX} \
      --search-prefix #{CREW_LIB_PREFIX} \
      --system #{@zig_global_cache_dir}/p \
      -Dcpu=baseline \
      -Demit-docs \
      -Demit-termcap \
      -Demit-terminfo \
      -Dgtk-x11=true \
      -Doptimize=ReleaseFast \
      -Dpie=true \
      -Dversion-string=#{version}-Chromebrew"
  end

  def self.install
    FileUtils.mv Dir.glob('build/*'), "#{CREW_DEST_DIR}/"
  end
end
