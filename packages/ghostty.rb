# Adapted from Arch Linux ghostty PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ghostty

require 'package'

class Ghostty < Package
  description 'Fast, native, feature-rich terminal emulator pushing modern features'
  homepage 'https://ghostty.org'
  version '1.1.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://release.files.ghostty.org/#{version}/ghostty-source.tar.gz"
  source_sha256 '7fcb5fed08bd23d54be138af4f63a78cf5addddbe40322465b520cf14c46f181'
  binary_compression 'tar.zst'

  depends_on 'libadwaita' # R
  depends_on 'libx11' # R
  depends_on 'zig' => :build

  def self.build
    @zig_global_cache_dir = `pwd`.chomp + '/zig_cache'
    FileUtils.mkdir_p @zig_global_cache_dir
    system "ZIG_GLOBAL_CACHE_DIR=#{@zig_global_cache_dir} ./nix/build-support/fetch-zig-cache.sh"
    system "DESTDIR=build zig build \
      --summary all \
      -p #{CREW_PREFIX} \
      --system #{@zig_global_cache_dir}/p \
      -Doptimize=ReleaseFast \
      -Demit-docs \
      -Dgtk-x11=true \
      -Dcpu=baseline \
      -Dpie=true \
      -Dversion-string=#{version}-Chromebrew"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('build/*'), "#{CREW_DEST_PREFIX}/"
  end
end
