require 'package'

class CMake < Package

  def self.cmake_options(options = '')
    return (@cmake_options = options if options)
  end

  def self.check?(bool = true)
    return (@check = bool)
  end

  def self.build
    system "cmake -B builddir -G Ninja #{CREW_CMAKE_OPTIONS} #{@cmake_options}"
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
