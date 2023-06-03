require 'package'
require_relative 'llvm_build'

class Llvm_bin < Package
  description 'LLVM: Everything except libLLVM'
  homepage Llvm_build.homepage
  version '16.0.5'
  # When upgrading llvm, be sure to upgrade llvm_libs in tandem.
  puts "#{self} version differs from llvm version #{Llvm_build.version}".orange if version != Llvm_build.version.to_s
  license Llvm_build.license
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_bin/16.0.5_armv7l/llvm_bin-16.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_bin/16.0.5_armv7l/llvm_bin-16.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_bin/16.0.5_i686/llvm_bin-16.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_bin/16.0.5_x86_64/llvm_bin-16.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '29c4775dd0f8355401c396d1a352dcffa9fde1c9295ce9ed638db51e6a24e464',
     armv7l: '29c4775dd0f8355401c396d1a352dcffa9fde1c9295ce9ed638db51e6a24e464',
       i686: 'a1e63344703bbc874cf82bcbb957fe41ffa06a8411294655218c42e6c1e0ac76',
     x86_64: '0105c7f9a4f6065553ab63bd320cf30e5d718eec30fc3f71e1761b4379ac508f'
  })

  depends_on 'llvm_build' => :build

  conflicts_ok

  def self.install
    puts 'Installing llvm_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'llvm_build.filelist')
    abort 'File list for llvm_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next unless filename.include?(CREW_LIB_PREFIX) && !filename.include?('.so') && !filename.include?('libLLVM')

      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{filename}"
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
