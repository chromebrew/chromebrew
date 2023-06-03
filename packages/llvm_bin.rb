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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.4_armv7l/llvm_libs-16.0.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.4_armv7l/llvm_libs-16.0.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.4_i686/llvm_libs-16.0.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/llvm_libs/16.0.4_x86_64/llvm_libs-16.0.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b6e5091f724e334ca371ac9b6e391496b2875b56e927f5f8cebccdf7e4f899bb',
     armv7l: 'b6e5091f724e334ca371ac9b6e391496b2875b56e927f5f8cebccdf7e4f899bb',
       i686: '35cc9ee58f6fb140cc3babfe96c0f472c04949f01439b06eee455cac3a9e647b',
     x86_64: '7c2a38326d08d6d69ccad8c47906d67956111b784359ca50dd67b7735d355027'
  })

  depends_on 'llvm' => :build
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
