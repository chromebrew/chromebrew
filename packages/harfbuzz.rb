require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '4.4.1'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.4.1_armv7l/harfbuzz-4.4.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.4.1_armv7l/harfbuzz-4.4.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.4.1_i686/harfbuzz-4.4.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.4.1_x86_64/harfbuzz-4.4.1-chromeos-x86_64.tar.zst',
  })
  binary_sha256({
    aarch64: '556b8124f7d4181f15111dd841cce4fdb9ab39914fa0fbd0516fda5e7d929a94',
     armv7l: '556b8124f7d4181f15111dd841cce4fdb9ab39914fa0fbd0516fda5e7d929a94',
       i686: '8acbf2871d86e2b8a91e85f4ab9945b435b5a1e2ac854ebac770544d3f4adbb4',
     x86_64: '2a03c4db970323bd94a886d3350d6aacde20f415a1f553342400443075c06588',
  })

  # provides freetype (sans harfbuzz), ragel, and a non-x11 cairo stub
  depends_on 'brotli'
  depends_on 'bz2'
  depends_on 'chafa'
  depends_on 'gcc'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'fontconfig'
  depends_on 'graphite'
  depends_on 'icu4c'
  depends_on 'libffi'
  depends_on 'libpng'
  depends_on 'pixman' # Needed for cairo subproject
  depends_on 'pcre'
  depends_on 'py3_six' => :build
  depends_on 'zlibpkg'

  no_env_options
  conflicts_ok

  def self.patch
    # Update to new versions of freetype as they come out.
    system "sed -i 's,revision=VER-2-11-0,revision=VER-2-12-0,g' subprojects/freetype2.wrap"
    system "sed -i 's,revision=c90faeb7492b1b778d18a796afe5c2e4b32a6356,revision=521a3a7bdb9299d511dcb1e4f243670141e53847,g' subprojects/cairo.wrap"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      --wrap-mode=default \
      --default-library=both \
      -Dbenchmark=disabled \
      -Dcairo=enabled \
      -Ddocs=disabled \
      -Dfreetype=enabled \
      -Dgraphite2=enabled \
      -Dintrospection=enabled \
      -Dragel_subproject=true \
      -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
    # The following are included the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end

  def self.preinstall
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? { |elem| elem[:name] == 'freetype' }
      system "sed -i '/freetype2/d;/libfreetype/d' filelist"
      system "sed -i '/freetype2/d;/libfreetype/d' dlist"
    end
  end

  def self.postinstall
    # This should become a function.
    # check for conflicts with other installed files
    @override_allowed = %w[fontconfig cairo]
    puts "Checking for conflicts with files from installed packages..."
    conflicts = []
    conflictscmd = %x[grep --exclude #{CREW_META_PATH}#{self.name}.filelist -Fxf #{CREW_META_PATH}#{self.name}.filelist #{CREW_META_PATH}*.filelist]
    conflicts << conflictscmd.gsub(/(\.filelist|#{CREW_META_PATH})/, '').split("\n")
    conflicts.reject!(&:empty?)
    unless conflicts.empty?
      if self.conflicts_ok?
        puts "Warning: There is a conflict with the same file in another package.".orange
      else
        puts "Error: There is a conflict with the same file in another package.".lightred
        @_errors = 1
      end
      conflicts.each do |conflict|
        conflict.each do |thisconflict|
          singleconflict = thisconflict.split(':',-1)
          if @override_allowed.include?(singleconflict[0])
            system "sed -i '\\\?^#{singleconflict[1]}?d'  #{CREW_META_PATH}/#{singleconflict[0]}.filelist"
          end
        end
      end
    end
  end
end
