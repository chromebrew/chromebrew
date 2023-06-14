require 'package'
require_relative 'gcc_build'

class Gcc_lib < Package
  description 'GCC shared libs except libgccjit'
  homepage Gcc_build.homepage
  version '13.1.0-1' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib, gcc_dev, and libssp in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version.to_s.gsub(/-.*/,
                                                                                                   '') != Gcc_build.version.to_s
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0-1_armv7l/gcc_lib-13.1.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0-1_armv7l/gcc_lib-13.1.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0-1_i686/gcc_lib-13.1.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0-1_x86_64/gcc_lib-13.1.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3c5c72d2955468c9aa44014ad3a880a3c988f5e9da174225634965fdae1a26c5',
     armv7l: '3c5c72d2955468c9aa44014ad3a880a3c988f5e9da174225634965fdae1a26c5',
       i686: '395ef2e6e37c5d3e2745d83f9c7aadc90cb11387a0099578ab98f6265d90c791',
     x86_64: '30fc5cd851e8785798dc5ddaf1f0fdd905e0f1abd0d3dd581cf0b12770c591e6'
  })

  depends_on 'gcc_build' => :build
  depends_on 'glibc' # R

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
