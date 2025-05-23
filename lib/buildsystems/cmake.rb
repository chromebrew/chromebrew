require 'package'
require 'require_gem'

class CMake < Package
  property :cmake_build_extras, :cmake_build_relative_dir, :cmake_install_extras, :cmake_options, :pre_cmake_options

  def self.build
    @cmake_build_relative_dir ||= '.'
    @crew_cmake_options = @no_lto ? CREW_CMAKE_OPTIONS.gsub('-flto=auto', '-fno-lto').sub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE', '') : CREW_CMAKE_OPTIONS

    method_list = methods.grep(/#{superclass.to_s.downcase}_/).delete_if { |i| send(i).blank? }
    unless method_list.empty?
      require_gem 'method_source'
      method_blocks = []
      method_strings = []
      method_list.sort.each do |method|
        @method_info = send method
        if @method_info.is_a? String
          method_strings << "#{method}: #{@method_info}".orange
        else
          method_blocks << @method_info.source.to_s.orange
        end
      end
      puts "Additional #{superclass.to_s.capitalize} options being used:".orange
      puts method_strings
      puts method_blocks
    end

    system "#{@pre_cmake_options} cmake -S #{@cmake_build_relative_dir} -B #{@cmake_build_relative_dir}/builddir -G Ninja #{@crew_cmake_options} #{@cmake_options}"
    system "#{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir"
    @cmake_build_extras&.call
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir install"
    @cmake_install_extras&.call
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "ctest -j --progress --test-dir #{@cmake_build_relative_dir}/builddir --rerun-failed --output-on-failure" if @run_tests
  end
end
