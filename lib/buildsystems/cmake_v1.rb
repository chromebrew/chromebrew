require 'package'

class Cmake_v1 < Package
  @_buildsystems_cmake_version = '1.0.0'

  def self.cmake_options (options = nil)
    if options
      @cmake_options = options
    end
    @cmake_options
  end

  def self.check? (bool)
    if bool == true
      @check = true
    else
      @check = false
    end
    @check
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

  if @check == true
    def self.check
      system 'samu -C builddir test'
    end
  end
end
