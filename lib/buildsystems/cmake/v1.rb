require 'package'

class Cmake_v1 < Package
  @_buildsystems_cmake_version = '1.0.0'

  def self.cmake_options (options = '')
    if options
      @cmake_options = options
    end
    return @cmake_options
  end

  def self.check? (bool = false)
    @check = bool
    return @check
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "#{CREW_ENV_OPTIONS} cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
            #{@cmake_options} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  if @check
    def self.check
      system 'samu -C builddir test'
    end
  end
end
