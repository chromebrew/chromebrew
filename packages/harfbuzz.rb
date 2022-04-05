require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '4.2.0'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.2.0_armv7l/harfbuzz-4.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.2.0_armv7l/harfbuzz-4.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.2.0_i686/harfbuzz-4.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.2.0_x86_64/harfbuzz-4.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0e2f9f45e620ec75db77481292a90273ad79b5afeca3c07afb24568917cef9c9',
     armv7l: '0e2f9f45e620ec75db77481292a90273ad79b5afeca3c07afb24568917cef9c9',
       i686: '14c173bb67126e2b0a862dd61b1071a7e3520d3235b923c9c95dd33a0564ac2d',
     x86_64: 'ae8e1ceb094880512c493f8a8559ec1162393a06756b8363517d39343086c684'
  })
  git_hashtag @_ver

  # provides libpng, freetype (sans harfbuzz), ragel, and a non-x11 cairo stub
  depends_on 'brotli'
  depends_on 'bz2'
  depends_on 'chafa'
  depends_on 'gcc11'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'fontconfig'
  depends_on 'graphite'
  depends_on 'icu4c'
  depends_on 'libffi'
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
          # puts "This conflict is " + thisconflict.inspect
          singleconflict = thisconflict.split(':',-1)
          puts singleconflict
          if @override_allowed.include?(singleconflict[0])
            system "sed -i '\\\?^#{singleconflict[1]}?d'  #{CREW_META_PATH}/#{singleconflict[0]}.filelist"
          end
        end
      end
    end
  end
end
