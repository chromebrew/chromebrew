require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.12.0' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.tr('.', '-')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.12.0_armv7l/freetype-2.12.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.12.0_armv7l/freetype-2.12.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.12.0_i686/freetype-2.12.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.12.0_x86_64/freetype-2.12.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7ff2e02d08ead4e7b5fb1a16d4e8f5551a4420a51a8b0dae8f12d33d308d469a',
     armv7l: '7ff2e02d08ead4e7b5fb1a16d4e8f5551a4420a51a8b0dae8f12d33d308d469a',
       i686: 'b2c34d291f9324105f712434274c4d360c3e98b8b567162d44b54ff74b22b3ba',
     x86_64: 'a49bad49bfc204855936a8124229f1e8b21cb11e719981dd925c76edfecea0de'
  })

  depends_on 'brotli'
  depends_on 'bz2'
  depends_on 'expat'
  depends_on 'gcc'
  depends_on 'glib'
  depends_on 'graphite'
  depends_on 'harfbuzz'
  depends_on 'librsvg'
  depends_on 'pcre'
  depends_on 'zlibpkg'
  # to avoid resetting mold usage
  no_env_options
  # This overwrites the freetype in harfbuzz, which have
  # epicircular dependencies on each other.
  conflicts_ok

  def self.build
    system 'pip3 install docwriter'
    system "meson #{CREW_MESON_OPTIONS} \
      -Dharfbuzz=enabled \
      builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.postinstall
    # make sure to delete downloaded files
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar -exec rm -rf {} \+"
    # This should become a function.
    # check for conflicts with other installed files
    @override_allowed = %w[fontconfig harfbuzz]
    puts "Checking for conflicts with files from installed packages..."
    conflicts = []
    conflictscmd = %x[grep --exclude #{CREW_META_PATH}#{self.name}.filelist -Fxf #{CREW_META_PATH}#{self.name}.filelist #{CREW_META_PATH}*.filelist]
    conflicts << conflictscmd.gsub(/(\.filelist|#{CREW_META_PATH})/, '').split("\n")
    conflicts.reject!(&:empty?)
    unless conflicts.empty?
      if self.conflicts_ok?
        puts "Handling conflict with the same file in another package.".orange
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
