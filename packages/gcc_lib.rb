require 'package'
require_relative 'gcc_build'

class Gcc_lib < Package
  description 'Libgcc'
  homepage Gcc_build.homepage
  version '13.1.0' # Do not use @_ver here, it will break the installer.
  license Gcc_build.license
  # When upgrading gcc_build, be sure to upgrade gcc_lib and gcc_dev in tandem.
  puts "#{self} version differs from gcc version #{Gcc_build.version}".orange if version != Gcc_build.version.to_s
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0_armv7l/gcc_lib-13.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0_armv7l/gcc_lib-13.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0_i686/gcc_lib-13.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc_lib/13.1.0_x86_64/gcc_lib-13.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '43e835c2e924a80bf0fd87a853a3f5692e3db97e6368a820f08da6065086e540',
     armv7l: '43e835c2e924a80bf0fd87a853a3f5692e3db97e6368a820f08da6065086e540',
       i686: '563c75cd3dba893bf6231f84e328fe368ec4307b599ad6bff72a8d34cd2e9251',
     x86_64: '98e1240095dd7dbfb3539f5c6d1450cb01a9674733b7490a5f32eff9c8458d86'
  })

  depends_on 'gcc_build' => :build
  depends_on 'glibc' # R

  def self.install
    puts 'Installing Gcc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc_build.filelist')
    abort 'File list for Gcc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?('.so') && filename.include?('libgcc_s')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
