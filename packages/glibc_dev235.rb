require 'package'
require_relative 'glibc_build235'

class Glibc_dev235 < Package
  description 'glibc: everything except what is in glibc_lib'
  homepage Glibc_build235.homepage
  version '2.35'
  license Glibc_build235.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18779266ab02bc47f080a3d12d710f6fca9539ce9d7d96d824bbb8d51294d530',
     armv7l: '18779266ab02bc47f080a3d12d710f6fca9539ce9d7d96d824bbb8d51294d530',
     x86_64: '79fecb7302d1e7e1da24f6ddec16c672cc3d21e93c549930e48c5290f5a31939'
  })

  depends_on 'glibc_build235' => :build
  depends_on 'glibc_lib235' # R

  def self.preflight
    abort 'Glibc_lib requires glibc = 2.35.' unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.35')
  end

  def self.install
    puts 'Installing Glibc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc_build235.filelist')
    abort 'File list for Glibc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).sort

    @filelist.each do |filename|
      next if filename.include?('.so') || filename.include?('bin/')

      @destpath = File.join(CREW_DEST_DIR, filename)
      # next unless File.file?(filename)

      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
