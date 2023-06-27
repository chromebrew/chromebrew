require 'package'

class CMake < Package

  def self.cmake_options(options = '')
    return (@cmake_options = options if options)
  end

  def self.check?(bool = true)
    return (@check = bool)
  end

  def self.build
    puts "Additional cmake_options being used: #{if @cmake_options.nil? or @cmake_options.empty? ; '<no cmake_options>' ; else ; @cmake_options ; end}".orange
    @crew_cmake_options = no_lto ? CREW_CMAKE_FNO_LTO_OPTIONS : CREW_CMAKE_OPTIONS
    system "cmake -B builddir -G Ninja #{@crew_cmake_options} #{@cmake_options}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  if @check
    def self.check
      system "#{CREW_NINJA} -C builddir test"
    end
  end
end
