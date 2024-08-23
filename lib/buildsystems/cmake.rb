require 'package'

class CMake < Package
  property :cmake_build_extras, :cmake_build_relative_dir, :cmake_install_extras, :cmake_options, :pre_cmake_options

  attr_accessor :cmake_build_relative_dir

  def initialize
    super
    @cmake_build_relative_dir = '.'
  end

  def self.build
    puts "Additional cmake_options being used: #{@pre_cmake_options.nil? ? '<no pre_cmake_options>' : @pre_cmake_options} #{@cmake_options.nil? ? '<no cmake_options>' : @cmake_options}".orange
    @crew_cmake_options = @no_lto ? CREW_CMAKE_FNO_LTO_OPTIONS : CREW_CMAKE_OPTIONS
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@pre_cmake_options} #{@mold_linker_prefix_cmd} cmake -C #{@cmake_build_relative_dir} -B builddir -G Ninja #{@crew_cmake_options} #{@cmake_options}"
    system "#{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir"
    @cmake_build_extras&.call
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir install"
    @cmake_install_extras&.call
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir test" if @run_tests
  end
end
