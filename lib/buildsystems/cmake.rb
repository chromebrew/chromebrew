require 'package'

class CMake < Package
  property :cmake_options, :pre_cmake_options

  def self.build
    puts "Additional cmake_options being used: #{@pre_cmake_options.nil? || @pre_cmake_options.empty? ? '<no pre_cmake_options>' : @pre_cmake_options} #{@cmake_options.nil? || @cmake_options.empty? ? '<no cmake_options>' : @cmake_options}".orange
    @crew_cmake_options = @no_lto ? CREW_CMAKE_FNO_LTO_OPTIONS : CREW_CMAKE_OPTIONS
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@pre_cmake_options} #{@mold_linker_prefix_cmd} cmake -B builddir -G Ninja #{@crew_cmake_options} #{@cmake_options}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C builddir test" if @run_tests
  end
end
