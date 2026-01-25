require 'package'

class Eudev_header < Package
  eudev_obj = Package.load_package("#{__dir__}/eudev.rb")
  description 'Gentoo standalone udev libudev.h for util_linux build.'
  homepage eudev_obj.homepage
  version eudev_obj.version
  # puts "#{self} version differs from eudev version #{eudev_obj.version}".orange if version != eudev_obj.version && !ENV['NESTED_CI']
  license eudev_obj.license
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02e4f17d9cbcce3d546211b306b9d8af99de6a1743622489373f9c197e2a5cab',
     armv7l: '02e4f17d9cbcce3d546211b306b9d8af99de6a1743622489373f9c197e2a5cab',
       i686: '908a55f63de10c8a068a32440fedf4959a4b668694de26583451a2e08d7967af',
     x86_64: '66935886caea98012f07997fab1805b3ab7d6e8c708f3a0604f122225bab709d'
  })

  depends_on 'eudev' => :build

  conflicts_ok
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing eudev to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'eudev.filelist')
    abort 'File list for eudev does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless filename.include?('libudev.h')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
