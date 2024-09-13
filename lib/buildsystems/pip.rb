Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
require 'json'
require 'package'
require_relative '../const'

class Pip < Package
  property :pip_install_extras, :pre_configure_options, :prerelease

  def self.install
    # Make sure Chromebrew pypi variables are set.
    # These need to be set as global or they don't work.
    pip_config = `pip config list`.chomp
    Kernel.system "pip config --user set global.index-url #{CREW_GITLAB_PKG_REPO}/pypi/simple", %i[err out] => File::NULL unless pip_config.include?("global.index-url='#{CREW_GITLAB_PKG_REPO}'")
    Kernel.system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
    Kernel.system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")
    pip_cache_dir = `pip cache dir`.chomp

    puts 'Checking for pip updates'.orange if CREW_VERBOSE
    system "python3 -s -m pip install -U pip | grep -v 'Requirement already satisfied'", exception: false
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
        system "python3 -s -m pip install --ignore-installed -U \"#{@cleaned_py_dep}\" | grep -v 'Requirement already satisfied'", exception: false
      end
    end
    puts "Installing #{@py_pkg} python module. This may take a while...".lightblue
    puts "Additional pre_configure_options being used: #{@pre_configure_options.nil? ? '<no pre_configure_options>' : @pre_configure_options}".orange
    puts "#{@py_pkg.capitalize} is configured to install a pre-release version." if prerelease
    system "MAKEFLAGS=-j#{CREW_NPROC} #{@pre_configure_options} python -s -m pip install --ignore-installed -U \"#{@py_pkg}==#{@py_pkg_chromebrew_version}\" | grep -v 'Requirement already satisfied'", exception: false

    if @source_url == 'SKIP'
      system "pip wheel -w #{pip_cache_dir} #{@py_pkg}"
    else
      system "pip wheel -w #{pip_cache_dir} git+#{source_url}"
    end

    @pip_files = `python3 -s -m pip show -f #{@py_pkg}`.chomp
    abort "pip install of #{@py_pkg} failed." if @pip_files.empty?
    @pip_files_base = @pip_files[/(?<=Location: ).*/, 0].concat('/')
    @pip_files_lines = @pip_files[/(?<=Files:\n)[\W|\w]*/, 0].split
    @pip_files_lines.each do |pip_file|
      @pip_path = File.expand_path("#{@pip_files_base}#{pip_file}")
      @destpath = File.join(CREW_DEST_DIR, @pip_path)
      # Handle older FileUtils from older ruby versions.
      FileUtils.mkdir_p File.dirname(@destpath) if Gem::Version.new(RUBY_VERSION.to_s) < Gem::Version.new('3.3')
      FileUtils.install @pip_path, @destpath
    end
    @pip_install_extras&.call
  end
end
