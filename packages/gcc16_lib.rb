require 'package'

class Gcc16_lib < Package
  gcc_build_obj = Package.load_package("#{__dir__}/gcc16_build.rb")
  description 'GCC shared libs except libgccjit'
  homepage gcc_build_obj.homepage
  version gcc_build_obj.version
  license gcc_build_obj.license
  # For major version GCC changes, be sure to update CREW_GCC_VER in
  # lib/const.rb install.sh, and rebuild binutils.
  # Also rebuild #{CREW_GCC_VER}_lib, #{CREW_GCC_VER}_dev, and
  # libssp whenever #{CREW_GCC_VER}_build is rebuilt.
  puts "#{self} version (#{version}) differs from gcc version #{gcc_build_obj.version}".orange if version != gcc_build_obj.version
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e6dd99962ae162b17950a092362667f7f8c96aa64a18864551020e929dc1300',
     armv7l: '9e6dd99962ae162b17950a092362667f7f8c96aa64a18864551020e929dc1300',
       i686: 'a148b61dd3a270d566786a4169b2d62e029b262541a01bc3fb0c2d4bde89ab89',
     x86_64: '822a6d58b7793e0de49b525dccc812179bc9da85a6ab3a6344d0c2cdd4bb7cfb'
  })

  depends_on 'gcc16_build' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxml2' => :library if ARCH == 'x86_64'

  conflicts_ok # Conflicts with gcc_lib.
  no_shrink
  no_source_build
  no_strip

  def self.install
    puts 'Installing gcc_build_obj to pull files for build...'.lightblue
    @filelist_path = File.join(CREW_META_PATH, 'gcc16_build.filelist')
    abort 'File list for gcc_build_obj does not exist!'.lightred unless File.file?(@filelist_path)
    @filelist = File.readlines(@filelist_path, chomp: true).grep(/^(?!#)/)

    @filelist.each do |filename|
      next unless filename.include?('.so') && !filename.include?('libgccjit')

      @destpath = File.join(CREW_DEST_DIR, filename)
      @filename_target = File.realpath(filename)
      FileUtils.install @filename_target, @destpath
    end
  end
end
