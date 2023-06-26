require 'package'
require_relative 'freetype'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '7.3.0'
  license 'Old-MIT, ISC and icu'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/7.3.0_armv7l/harfbuzz-7.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/7.3.0_armv7l/harfbuzz-7.3.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/7.3.0_x86_64/harfbuzz-7.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8eae2341b560a92f4e214b369e670e9d1cb195cbcc60489d9718fb7bfec615b0',
     armv7l: '8eae2341b560a92f4e214b369e670e9d1cb195cbcc60489d9718fb7bfec615b0',
     x86_64: '4bd7fadc454ddc205e67884bef2c926399174344ee70c1cbcb0d59828933d044'
  })

  depends_on 'brotli' # R
  depends_on 'bz2' # R
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
  depends_on 'zlibpkg' # R

  # provides freetype (sans harfbuzz), ragel, and a non-x11 cairo stub

  def self.prebuild
    %w[fontconfig freetype].each do |build_exclusion|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{build_exclusion}.filelist"

      puts "#{build_exclusion} needs to be uninstalled before this build.".lightred
    end
  end

  def self.patch
    File.write 'subprojects/freetype2.wrap', <<~FREETYPE2_WRAP_EOF
      [wrap-git]
      directory = freetype-#{Freetype.version}
      url=https://gitlab.freedesktop.org/freetype/freetype.git
      revision=VER-#{Freetype.version.tr('.', '-')}
      depth=1

      [provide]
      freetype2 = freetype_dep
      freetype = freetype_dep
    FREETYPE2_WRAP_EOF
  end

  def self.build
    system 'update-ca-certificates --fresh'
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
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
    system "#{CREW_NINJA} -C builddir"
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
        puts "#{@dest} is a library"
        @dest_so = @dest if @dest.include?('libcairo')
      elsif @dest_file.include?('symbolic link')
        puts "#{@dest} is a symbolic link"
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
    # Create libtool file. Needed by handbrake build
    return if File.file?("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la")

    @libname = name.to_s.start_with?('lib') ? name.downcase : "lib#{name.downcase}"
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}.so*"]
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}-*.so*"] if @libnames.empty?
    @libnames.each do |s|
      s.gsub!("#{CREW_DEST_LIB_PREFIX}/", '')
    end
    @dlname = @libnames.grep(/.so./).first
    @libname = @dlname.gsub(/.so.\d+/, '')
    @longest_libname = @libnames.max_by(&:length)
    @libvars = @longest_libname.rpartition('.so.')[2].split('.')

    @libtool_file = <<~LIBTOOLEOF
      # #{@libname}.la - a libtool library file
      # Generated by libtool (GNU libtool) (Created by Chromebrew)
      #
      # Please DO NOT delete this file!
      # It is necessary for linking the library.

      # The name that we can dlopen(3).
      dlname='#{@dlname}'

      # Names of this library.
      library_names='#{@libnames.reverse.join(' ')}'

      # The name of the static archive.
      old_library='#{@libname}.a'

      # Linker flags that cannot go in dependency_libs.
      inherited_linker_flags=''

      # Libraries that this one depends upon.
      dependency_libs=''

      # Names of additional weak libraries provided by this library
      weak_library_names=''

      # Version information for #{name}.
      current=#{@libvars[0]}
      age=#{@libvars[1]}
      revision=#{@libvars[2]}

      # Is this an already installed library?
      installed=yes

      # Should we warn about portability when linking against -modules?
      shouldnotlink=no

      # Files to dlopen/dlpreopen
      dlopen=''
      dlpreopen=''

      # Directory that this library needs to be installed in:
      libdir='#{CREW_LIB_PREFIX}'
    LIBTOOLEOF
    File.write("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la", @libtool_file)
  end
end
