require 'package'
Package.load_package("#{__dir__}/glibc_build237.rb")

class Glibc_dev237 < Package
  description 'glibc: everything except what is in glibc_lib'
  homepage Glibc_build237.homepage
  version '2.37-patchelf1'
  license Glibc_build237.license
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc071b97e0eaa0e1e9b6bdad4ab378112dbef849453fbf3bc4e10e22260b1841',
     armv7l: 'fc071b97e0eaa0e1e9b6bdad4ab378112dbef849453fbf3bc4e10e22260b1841',
     x86_64: '72b99a7f86687958639d0935d686260f50afc45e0209ff717bbd42e4ef9d7bfb'
  })

  depends_on 'glibc_build237' => :build
  depends_on 'glibc_lib237' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_upstream_update

  def self.install
    puts 'Installing Glibc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc_build237.filelist')
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
