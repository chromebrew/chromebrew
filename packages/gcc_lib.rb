require 'package'
require_relative 'gcc_build'

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '13.2.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version.to_s.gsub(/-.*/,
                                                                                                   '') != Gcc_build.version
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.2.0_armv7l/gcc_lib-13.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.2.0_armv7l/gcc_lib-13.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.2.0_i686/gcc_lib-13.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.2.0_x86_64/gcc_lib-13.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '04c6f1af5d8b005dcea7d0050f7ea52d8c4a37def289287e590000056d707e67',
     armv7l: '04c6f1af5d8b005dcea7d0050f7ea52d8c4a37def289287e590000056d707e67',
       i686: 'b0aeb79cfc7df8b46b41f36902350ac94e9a7e0f04678f85c0fbb01a24f86235',
     x86_64: '386695ced2bc2aeb93fc96b2176f3638a3ac0271667bdd9b058ff14bf0e97256'
  })

  depends_on 'gcc_build' => :build
  depends_on 'glibc' # R
  no_shrink
  no_strip

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
