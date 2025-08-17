require 'package'
Package.load_package("#{__dir__}/glibc_build237.rb")

class Glibc_dev237 < Package
  description 'glibc: everything except what is in glibc_lib'
  homepage Glibc_build237.homepage
  version '2.37-patchelf2'
  license Glibc_build237.license
  compatibility 'aarch64 armv7l x86_64'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd30575a011326b56ff235078aeb881c2a3d24619cb1697f7eed9b71bd9a33b42',
     armv7l: 'd30575a011326b56ff235078aeb881c2a3d24619cb1697f7eed9b71bd9a33b42',
     x86_64: '9689db1bfc8580b61409cc9b23591c1560b3651a2f1474815aab301611866553'
  })

  depends_on 'glibc_build237' => :build
  depends_on 'glibc_lib237' # R

  conflicts_ok
  no_shrink
  no_source_build
  no_strip
  no_upstream_update

  def self.install
    puts 'Installing Glibc_build to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'glibc_build237.filelist')
    abort 'File list for Glibc_build does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next if filename.include?('.so') || filename.include?('bin/')

      @destpath = File.join(CREW_DEST_DIR, filename)
      # next unless File.file?(filename)

      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
