require 'buildsystems/meson'
Package.load_package("#{__dir__}/cairo.rb")
Package.load_package("#{__dir__}/fontconfig.rb")
Package.load_package("#{__dir__}/freetype.rb")
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Harfbuzz < Meson
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://harfbuzz.github.io/'
  version '10.0.1-icu75.1'
  license 'Old-MIT, ISC and icu'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46b5c610b6fbe6682cba6d1ef7f003478c1bc938e6d08f844e0df00157c19c8a',
     armv7l: '46b5c610b6fbe6682cba6d1ef7f003478c1bc938e6d08f844e0df00157c19c8a',
     x86_64: '41d90e25a0f0374383ba8dc3d0a74db8eb54bf95bf64c92d984be283640caecb'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'chafa' # R
  depends_on 'expat' # R
  # depends_on 'fontconfig' # This pulls in freetype.
  # depends_on 'freetype' # R harfbuzz provides this.
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphite' # R
  depends_on 'icu4c' # R
  depends_on 'json_c' => :build
  depends_on 'libffi' => :build
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'lzo' # R
  depends_on 'patchelf' => :build
  depends_on 'pcre' => :build
  depends_on 'pixman' # R Needed for cairo subproject.
  depends_on 'zlib' # R

  # provides freetype (sans harfbuzz), ragel, and a non-x11 cairo stub

  meson_options '--wrap-mode=default \
      --default-library=both \
      -Dbenchmark=disabled \
      -Dcairo=enabled \
      -Ddocs=disabled \
      -Dfreetype=enabled \
      -Dgraphite2=enabled \
      -Dintrospection=enabled \
      -Dragel_subproject=true \
      -Dtests=disabled'

  def self.prebuild
    %w[fontconfig freetype].each do |build_exclusion|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{build_exclusion}.filelist"

      puts "#{build_exclusion} needs to be uninstalled before this build.".lightred
    end
    system 'update-ca-certificates --fresh'
  end

  def self.patch
    File.write 'subprojects/freetype2.wrap', <<~FREETYPE2_WRAP_EOF
      [wrap-git]
      directory = freetype-#{Freetype.version}
      url=https://gitlab.freedesktop.org/freetype/freetype.git
      revision=#{Freetype.git_hashtag}
      depth=1

      [provide]
      freetype2 = freetype_dep
      freetype = freetype_dep
    FREETYPE2_WRAP_EOF

    File.write 'subprojects/cairo.wrap', <<~CAIRO_WRAP_EOF
      [wrap-git]
      directory = cairo
      url=https://gitlab.freedesktop.org/cairo/cairo.git
      revision=#{Cairo.git_hashtag}
      depth=1

      [provide]
      dependency_names = cairo
    CAIRO_WRAP_EOF

    FileUtils.mkdir_p 'subprojects/packagefiles'
    File.write 'subprojects/packagefiles/fontconfig.diff', <<~FCSTDINT_WRAP_EOF
      diff -Npaur a/src/fcstdint.h b/src/fcstdint.h
      --- a/src/fcstdint.h	1969-12-31 19:00:00.000000000 -0500
      +++ b/src/fcstdint.h	2024-05-14 13:58:12.402498838 -0400
      @@ -0,0 +1,8 @@
      +#ifndef _FONTCONFIG_SRC_FCSTDINT_H
      +#define _FONTCONFIG_SRC_FCSTDINT_H 1
      +#ifndef _GENERATED_STDINT_H
      +#define _GENERATED_STDINT_H "fontconfig #{Fontconfig.version}"
      +#define _STDINT_HAVE_STDINT_H 1
      +#include <stdint.h>
      +#endif
      +#endif
    FCSTDINT_WRAP_EOF

    File.write 'subprojects/fontconfig.wrap', <<~FONTCONFIG_WRAP_EOF
      [wrap-git]
      directory = fontconfig
      url=https://gitlab.freedesktop.org/fontconfig/fontconfig.git
      revision=#{Fontconfig.git_hashtag}
      depth=1
      diff_files = fontconfig.diff

      [provide]
      dependency_names = fontconfig
    FONTCONFIG_WRAP_EOF
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # As per https://chromium-review.googlesource.com/c/chromium/src/+/696241
    # Rename the freetype libaries included, and then use patchelf to redirect
    # the harfbuzz libaries to those libraries.
    # Rename the freetype libraries in this package.

    # Handle Cairo files & libraries
    @cairo_libs = Dir["#{CREW_DEST_LIB_PREFIX}/libcairo.*"]
    @dest_links = []
    @cairo_libs.each do |s|
      @dest = s.gsub('libcairo', 'harfbuzz-libcairo')
      FileUtils.mv s, @dest
      @dest_file = `file #{@dest}`.chomp
      if @dest_file.include?('LSB shared object')
        @dest_so = @dest if @dest.include?('libcairo')
      elsif @dest_file.include?('symbolic link')
        @dest_links.push @dest
      end
    end
    # Fix broken links
    @dest_links.each do |broken_link|
      Dir.chdir(CREW_DEST_LIB_PREFIX) do
        FileUtils.ln_sf File.basename(@dest_so), File.basename(broken_link)
      end
    end

    # Remove other cairo files.
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/bin/cairo-trace"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/include/cairo"
    FileUtils.rm_rf Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/cairo-*"]
    FileUtils.rm_rf Dir["#{CREW_DEST_LIB_PREFIX}/libcairo-*"]
    FileUtils.rm_rf Dir["#{CREW_DEST_LIB_PREFIX}/cairo"]

    # Set needed cairo library to our renamed package.
    # Only libharfbuzz-cairo needs replacement with patchelf.
    @harfbuzz_lib = Dir["#{CREW_DEST_LIB_PREFIX}/libharfbuzz-cairo.so.0.*.0"]
    @harfbuzz_lib.each do |s|
      system "patchelf --replace-needed libcairo.so.2 harfbuzz-libcairo.so.2 #{s}"
    end

    # Handle Freetype files & libraries
    @freetype_libs = Dir["#{CREW_DEST_LIB_PREFIX}/libfreetype.*"]
    @dest_links = []
    @freetype_libs.each do |s|
      @dest = s.gsub('libfreetype', 'libharfbuzz-freetype')
      FileUtils.mv s, @dest
      @dest_file = `file #{@dest}`.chomp
      if @dest_file.include?('LSB shared object')
        @dest_so = @dest
      elsif @dest_file.include?('symbolic link')
        @dest_links.push @dest
      end
    end
    # Fix broken links
    @dest_links.each do |broken_link|
      Dir.chdir(CREW_DEST_LIB_PREFIX) do
        FileUtils.ln_sf File.basename(@dest_so), File.basename(broken_link)
      end
    end

    # Adjust other freetype files to avoid conflicts.
    FileUtils.mv "#{CREW_DEST_PREFIX}/include/freetype2", "#{CREW_DEST_PREFIX}/include/harfbuzz-freetype2"
    system "sed -i 's/lfreetype/lharfbuzz-freetype/g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/freetype2.pc"
    system "sed -i 's/freetype2/harfbuzz-freetype2/g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/freetype2.pc"

    # Set needed freetype library to our renamed package.
    # Only libharfbuzz needs replacement with patchelf.
    @libharfbuzz = Dir["#{CREW_DEST_LIB_PREFIX}/libharfbuzz.so.0.*.0"]
    @libharfbuzz.each do |s|
      system "patchelf --replace-needed libfreetype.so.6 libharfbuzz-freetype.so.6 #{s}"
    end

    # Handle Fontconfig files & libraries
    @fontconfig_libs = Dir["#{CREW_DEST_LIB_PREFIX}/libfontconfig.*"]
    @dest_links = []
    @fontconfig_libs.each do |s|
      @dest = s.gsub('libfontconfig', 'harfbuzz-libfontconfig')
      FileUtils.mv s, @dest
      @dest_file = `file #{@dest}`.chomp
      if @dest_file.include?('LSB shared object')
        @dest_so = @dest if @dest.include?('libfontconfig')
      elsif @dest_file.include?('symbolic link')
        @dest_links.push @dest
      end
    end
    # Fix broken links
    @dest_links.each do |broken_link|
      Dir.chdir(CREW_DEST_LIB_PREFIX) do
        FileUtils.ln_sf File.basename(@dest_so), File.basename(broken_link)
      end
    end

    # Remove other fontconfig files.
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/bin/fc-*"]
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/include/fontconfig"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/fontconfig"
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/share/gettext/its/fontconfig*"]
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/share/*/*/*/fontconfig*"]
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/xml/fontconfig"
    FileUtils.rm_rf "#{CREW_DEST_LIB_PREFIX}/pkgconfig/fontconfig.pc"

    # Set needed fontconfig libraries to our renamed package.
    # Only libharfbuzz-cairo * libcairo need replacements with patchelf.
    # This is for the cairo library built as a subproject.
    @libharfbuzz_cairo = Dir["#{CREW_DEST_LIB_PREFIX}/libharfbuzz-cairo.so.0.*.0"]
    @libharfbuzz_cairo.each do |s|
      system "patchelf --replace-needed libfontconfig.so.1 harfbuzz-libfontconfig.so.1 #{s}"
    end
    # This is for the libcairo library built as part of harfbuzz itself.
    @harfbuzz_libcairo = Dir["#{CREW_DEST_LIB_PREFIX}/harfbuzz-libcairo.so.0.*.0"]
    @harfbuzz_libcairo.each do |s|
      system "patchelf --replace-needed libfontconfig.so.1 harfbuzz-libfontconfig.so.1 #{s}"
    end

    # The following are included the libpng package.
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/libpng*"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/include/libpng16/png*"]
    FileUtils.rm Dir["#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"]
  end
end
