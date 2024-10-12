Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
require 'json'
require 'package'

def get_pip_info(pip_pkg_name = nil)
  @pip_show = nil
  @pip_pkg_version = nil
  @pip_show_location = nil
  @pip_show_files = []
  @pip_show = `python3 -s -m pip --no-color show -f #{pip_pkg_name}`.chomp
  # Error out if the pip install has no files.
  unless @pip_show.include?('Files:')
    puts @pip_show
    puts "pip install of #{pip_pkg_name} failed.".lightred
    return false
  end
  @pip_pkg_version = @pip_show[/(?<=Version: ).*/, 0]
  @pip_show_location = @pip_show[/(?<=Location: ).*/, 0].concat('/')
  @pip_show_files = @pip_show[/(?<=Files:\n)[\W|\w]*/, 0].split
  return true
end

def pip_hard_reinstall
  puts "Cleaning #{@py_pkg} and attempting reinstall...".lightpurple
  # Try installing from network wheels
  # as per https://stackoverflow.com/a/71119218
  pip_site_packages_folder = `python3 -c "import sysconfig; print(sysconfig.get_paths()['purelib'])"`.chomp
  Kernel.system 'python3 -m pip install trash-cli'
  Kernel.system "trash-put #{pip_site_packages_folder}/#{@py_pkg}*"
  Kernel.system "PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 python3 -m pip install --force-reinstall --upgrade '#{@py_pkg}==#{@py_pkg_chromebrew_version}'"
  get_pip_info(@py_pkg)
end

class Pip < Package
  property :pip_install_extras, :pre_configure_options

  def self.install
    @pip_cache_dir = `pip cache dir`.chomp
    @pip_cache_dest_dir = File.join(CREW_DEST_DIR, @pip_cache_dir)

    # Make sure Chromebrew pypi variables are set.
    # These need to be set as global or they don't work.
    pip_config = `pip config list`.chomp
    Kernel.system "pip config --user set global.index-url #{CREW_GITLAB_PKG_REPO}/pypi/simple", %i[err out] => File::NULL unless pip_config.include?("global.index-url='#{CREW_GITLAB_PKG_REPO}'")
    Kernel.system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
    Kernel.system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")

    puts 'Checking for pip updates'.orange if CREW_VERBOSE
    puts 'Updating pip...'.orange unless `python3 -s -m pip install --no-color -U pip`.include?('Requirement already satisfied')
    @py_pkg = name.gsub('py3_', '')
    @py_pkg_chromebrew_version = version.gsub(/-py3\.\d{2}/, '').gsub(/-icu\d{2}\.\d/, '')
    puts "Checking for #{@py_pkg} python dependencies...".orange if CREW_VERBOSE
    @py_pkg_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/json`.chomp
    @py_pkg_pypi_hash = JSON.parse(@py_pkg_pypi)
    @py_pkg_version = @py_pkg_pypi_hash['info']['version']
    @py_pkg_versioned_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/#{@py_pkg_version}/json`.chomp
    @py_pkg_versioned_pypi_hash = JSON.parse(@py_pkg_versioned_pypi)
    @py_pkg_deps = @py_pkg_versioned_pypi_hash['info']['requires_dist']
    # We don't want extra packages listed in the dependency list, since
    # those are optional.
    @py_pkg_deps.reject! { |x| x.include?('extra ==') } unless @py_pkg_deps.to_s.empty?
    unless @py_pkg_deps.to_s.empty?
      puts "Installing #{@py_pkg} python dependencies with pip...".orange
      @py_pkg_deps.each do |pip_dep|
        @cleaned_py_dep = pip_dep[/[^;]+/]
        puts "——Installing: #{@cleaned_py_dep}".gray
        system "PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 python3 -s -m pip install #{prerelease? ? '--pre' : ''} --ignore-installed -U \"#{@cleaned_py_dep}\" | grep -v 'Requirement already satisfied'", exception: false
      end
    end
    puts "Installing #{@py_pkg} python module. This may take a while...".lightblue
    puts "Additional pre_configure_options being used: #{@pre_configure_options.nil? ? '<no pre_configure_options>' : @pre_configure_options}".orange
    puts "#{@py_pkg.capitalize} is configured to install a pre-release version." if prerelease?

    # Build wheel if pip install fails, since that implies a wheel isn't available.
    puts "Trying to install #{@py_pkg}==#{@py_pkg_chromebrew_version}" if CREW_DEBUG
    Kernel.system "PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 MAKEFLAGS=-j#{CREW_NPROC} #{@pre_configure_options} python3 -s -m pip install --no-warn-conflicts --force-reinstall #{prerelease? ? '--pre' : ''} --no-deps --ignore-installed -U --only-binary :all: #{@py_pkg}==#{@py_pkg_chromebrew_version}"
    get_pip_info(@py_pkg)
    pip_hard_reinstall unless @py_pkg_chromebrew_version == @pip_pkg_version
    if CREW_DEBUG
      puts "@py_pkg_chromebrew_version is #{@py_pkg_chromebrew_version}"
      puts "@pip_pkg_version is #{@pip_pkg_version}"
    end
    if @py_pkg_chromebrew_version == @pip_pkg_version
      puts "A wheel for #{@py_pkg}==#{@py_pkg_chromebrew_version} was found!".lightblue
    else
      puts "A wheel for #{@py_pkg}==#{@py_pkg_chromebrew_version} was unavailable, so we will build a wheel.".orange
      Kernel.system "PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 python3 -m pip install #{prerelease? ? '--pre' : ''} --force-reinstall --upgrade '#{@py_pkg}==#{@py_pkg_chromebrew_version}'" unless prerelease?
      # Assume all pip non-SKIP sources are git.
      @pip_wheel = if @source_url == 'SKIP'
                     `PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 MAKEFLAGS=-j#{CREW_NPROC} #{@pre_configure_options} python3 -m pip wheel #{prerelease? ? '--pre' : ''} -w #{@pip_cache_dir} #{@py_pkg}==#{@py_pkg_version}`[/(?<=filename=)(.*)*?(\S+)/, 0]
                   else
                     `PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1 MAKEFLAGS=-j#{CREW_NPROC} #{@pre_configure_options} python3 -m pip wheel #{prerelease? ? '--pre' : ''} -w #{@pip_cache_dir} git+#{source_url}`[/(?<=filename=)(.*)*?(\S+)/, 0]
                   end
      puts "@pip_wheel is #{@pip_wheel}" if CREW_DEBUG
      FileUtils.install File.join(@pip_cache_dir, @pip_wheel), @pip_cache_dest_dir
      Kernel.system "python3 -m pip install #{prerelease? ? '--pre' : ''} --force-reinstall --upgrade #{File.join(@pip_cache_dir, @pip_wheel)}"
      # Check the just-installed package...
      if get_pip_info(@py_pkg)
        puts "Note that #{@py_pkg}==#{@pip_pkg_version} is installed, which is different from the #{@py_pkg_chromebrew_version}. Please update the package file.".lightpurple if @py_pkg_chromebrew_version != @pip_pkg_version
      else
        pip_hard_reinstall
      end
    end

    abort "#{@py_pkg} could not installed!".lightred unless get_pip_info(@py_pkg)
    @pip_show_files.each do |pip_file|
      @pip_file_path = File.expand_path("#{@pip_show_location}#{pip_file}")
      @pip_file_destpath = File.join(CREW_DEST_DIR, @pip_file_path)
      # Handle older FileUtils from older ruby versions.
      FileUtils.mkdir_p File.dirname(@pip_file_destpath) if Gem::Version.new(RUBY_VERSION.to_s) < Gem::Version.new('3.3')
      begin
        FileUtils.install @pip_file_path, @pip_file_destpath
      rescue Errno::ENOENT
        puts @pip_show_files
        abort "Problem installing #{@pip_file_path} from #{@py_pkg}==#{@pip_pkg_version} to #{@pip_file_destpath}".lightred
      end
    end
    @pip_install_extras&.call
    puts "#{@py_pkg}==#{@pip_pkg_version} installed.".lightgreen
  end
end
