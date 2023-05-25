require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.39'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/libpng/code.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.39_armv7l/libpng-1.6.39-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.39_armv7l/libpng-1.6.39-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.39_i686/libpng-1.6.39-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.39_x86_64/libpng-1.6.39-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '931e483e593bede53cc971755a9d8e6dbaa023d05017855a1aa0673640882ef9',
     armv7l: '931e483e593bede53cc971755a9d8e6dbaa023d05017855a1aa0673640882ef9',
       i686: '8380cd281ec792f8819621b0f27dc52a1c4d466ca44e2ac5a046220b3267dd1c',
     x86_64: '6813487ba62c178ca6fab45a9c2a851d48ea57f4cdd3b85be184be647195503a'
  })

  depends_on 'zlibpkg'
  depends_on 'glibc' # R

  def self.build
    system "cmake \
      -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -DPNG_STATIC=OFF \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
