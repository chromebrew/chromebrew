require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '5.2.0'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/5.2.0_armv7l/harfbuzz-5.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/5.2.0_armv7l/harfbuzz-5.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/5.2.0_i686/harfbuzz-5.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/5.2.0_x86_64/harfbuzz-5.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c9e3fb9162a5976f57f42ff1c7985697192597d5080064d3b1da7133eaa5b1b1',
     armv7l: 'c9e3fb9162a5976f57f42ff1c7985697192597d5080064d3b1da7133eaa5b1b1',
       i686: 'ac49731b4a83fd3683b9961a5811cc100e1cf109773f8966dd398adc5f2e3f9c',
     x86_64: '1e8922ae353da616f936e495779e7777acafa2166d010b4f3b1fc2e8ebb4ea5c'
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
    system 'mold -run ninja -C builddir'
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
    puts 'Checking for conflicts with files from installed packages...'
    conflicts = []
    conflictscmd = `grep --exclude #{CREW_META_PATH}#{name}.filelist -Fxf #{CREW_META_PATH}#{name}.filelist #{CREW_META_PATH}*.filelist`
    conflicts << conflictscmd.gsub(/(\.filelist|#{CREW_META_PATH})/, '').split("\n")
    conflicts.reject!(&:empty?)
    unless conflicts.empty?
      if conflicts_ok?
        puts 'Warning: There is a conflict with the same file in another package.'.orange
      else
        puts 'Error: There is a conflict with the same file in another package.'.lightred
        @_errors = 1
      end
      conflicts.each do |conflict|
        conflict.each do |thisconflict|
          singleconflict = thisconflict.split(':', -1)
          system "sed -i '\\\?^#{singleconflict[1]}?d'  #{CREW_META_PATH}/#{singleconflict[0]}.filelist" if @override_allowed.include?(singleconflict[0])
        end
      end
    end
  end
end
