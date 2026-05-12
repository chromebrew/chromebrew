# lib/convenience_functions.rb
# Extracted bits of crew-specific code that we use frequently enough that it makes sense to split them out to here.
require 'json'
require_relative 'color'
require_relative 'const'
require_relative 'crewlog'
require_relative 'downloader'

# Reimplementation of .blank? method from ActiveSupport
class NilClass; def blank? = true;         end
class Numeric;  def blank? = false;        end
class Proc;     def blank? = false;        end
class Array;    def blank? = empty?;       end
class Hash;     def blank? = empty?;       end
class Symbol;   def blank? = empty?;       end
class String;   def blank? = strip.empty?; end

class ConvenienceFunctions
  def self.determine_conflicts(pkg_name, filelist = File.join(CREW_META_PATH, "#{pkg_name}.filelist"), exclude_suffix = nil, verbose: false)
    conflicts       = {}
    target_filelist = File.readlines(filelist, chomp: true).grep(/^(?!#)/)

    puts 'Checking for conflicts with files from installed packages...'.orange if verbose

    Dir[File.join(CREW_META_PATH, '*.filelist')].each do |filelist|
      filelist_name = File.basename(filelist, '.filelist')

      # skip filelist belongs to the same package/explicitly excluded
      next if pkg_name == filelist_name || (exclude_suffix && filelist_name.end_with?(exclude_suffix))

      # find out identical file paths with intersection
      conflict = (target_filelist & File.readlines(filelist, chomp: true)).reject(&:empty?)
      conflicts[filelist_name] = conflict if conflict.any?
    end

    return conflicts
  end

  def self.determine_recursive_deps(d_pkg_input, dependency_graphs: {})
    require_gem 'dagwood'
    # How to hardcode a dependency:
    # @gcc_lib_graph = Dagwood::DependencyGraph.new(gcc_lib: %i[glibc])
    # @glibc_graph = Dagwood::DependencyGraph.new(glibc: nil)
    # @glibc_build227_graph = Dagwood::DependencyGraph.new(glibc_build227: %i[glibc])
    # @glibc_build227_graph.merge(@glibc_graph)
    # @gcc_lib_graph.merge(@glibc_graph)
    [d_pkg_input].flatten.each do |d_pkg|
      d_pkg_obj = Package.load_package("packages/#{d_pkg}.rb")
      d_pkg_deps = d_pkg_obj.dependencies.map { |key, value| key.to_s if value == [[], nil] }.compact
      # Pull in build dependencies if necessary.
      if (d_pkg.include?('_lib') || d_pkg.include?('_dev')) && !d_pkg.include?('gcc_lib')
        puts "#{"#{__LINE__}: " if CREW_VERBOSE}#{d_pkg} includes _dev || _lib, pulling build deps.".orange
        # d_pkg_deps = d_pkg_obj.get_deps_list(exclude_buildessential: false).delete_if { |d| ( d == 'glibc' || d == 'gcc_lib' ) }
        d_pkg_deps = d_pkg_obj.dependencies.map { |key, _value| key.to_s }.compact.delete_if { |d| %w[glibc gcc_lib].include?(d) }
      end
      dependency_graphs[d_pkg] = Dagwood::DependencyGraph.new({ d_pkg.to_sym => (d_pkg_deps.map &:to_sym) }) if dependency_graphs[d_pkg].nil?

      next unless !dependency_graphs[d_pkg].nil? && !dependency_graphs[d_pkg].dependencies.nil?

      next if d_pkg_deps.empty?
      d_pkg_deps.each do |d|
        dependency_graphs = determine_recursive_deps(d, dependency_graphs:) if dependency_graphs[d].nil?
        begin
          # puts "#{"#{__LINE__}: " if CREW_VERBOSE}order for #{d} is #{instance_variable_get("@#{d}_graph").order}".lightpurple
          # puts "#{"#{__LINE__}: " if CREW_VERBOSE}order for #{d} is #{dependency_graphs[d_pkg].order}".lightpurple
          # Make sure that the dependency tree for each d_pkg dependency
          # d is copacetic. If not error out with a complaint.
          dependency_graphs[d_pkg].order
        rescue TSort::Cyclic => e
          puts "#{"#{__LINE__}: " if CREW_VERBOSE}Error processing dependencies for #{d_pkg}:".lightred
          puts "#{"#{__LINE__}: " if CREW_VERBOSE}Circular dependency detected from #{dependency_graphs[d].dependencies}:".lightred
          abort "#{"#{__LINE__}: " if CREW_VERBOSE}#{e.message}".lightred
        end
        dependency_graphs[d_pkg] = dependency_graphs[d_pkg].merge(dependency_graphs[d]) unless dependency_graphs[d].dependencies.nil?
      end
    end

    return dependency_graphs
  end

  def self.get_package_disk_size(filelist)
    filelist.sum do |filename|
      # Skip calculating the filesize if the file doesn't exist.
      next 0 unless File.file?(filename)

      # Ignore symlinks to prevent duplicating calculation.
      next 0 if File.symlink?(filename)

      # Add the size of the file to the total size.
      File.size(filename)
    end
  end

  def self.load_symbolized_json
    unless File.file?(File.join(CREW_CONFIG_PATH, 'device.json'))
      puts 'Creating device.json.'
      device = {
        'architecture' => ARCH,
        'installed_packages' => []
      }
      FileUtils.mkdir_p CREW_CONFIG_PATH
      File.write(File.join(CREW_CONFIG_PATH, 'device.json'), JSON[device])
    end
    return JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'), symbolize_names: true).transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
  end

  def self.order_recursive_deps(d_pkg_input)
    d_pkgs = [d_pkg_input].flatten
    puts "#{"#{__LINE__}: " if CREW_VERBOSE}Processing dependencies...".lightpurple
    dependency_graphs = determine_recursive_deps(d_pkgs)
    input_pkgs = d_pkgs.to_set
    merge_base = dependency_graphs[d_pkgs.pop]

    d_pkgs.each do |p|
      begin
        merge_base.order
      rescue TSort::Cyclic => e
        puts "#{"#{__LINE__}: " if CREW_VERBOSE}Circular dependency detected from #{merge_base.dependencies}:".lightpurple
        abort e.message.to_s.lightred
      end
      merge_base = merge_base.merge(dependency_graphs[p])
      # puts "#{"#{__LINE__}: " if CREW_VERBOSE}merge_base.order is now #{merge_base.order}".lightpurple
    end
    package_deps_build_order = merge_base.order.to_set(&:to_s)
    # Want the intersection of these sets, but the intersection appears
    # to reorder the result, which isn't what we want.
    return package_deps_build_order.delete_if { |p| !input_pkgs.include? p }.to_a
  end

  def self.print_recursive_deps(d_pkg_input, dependency_graphs)
    [d_pkg_input].flatten.each do |p|
      abort "@#{p}_graph does not exist!".lightred unless !dependency_graphs[p].nil? && !dependency_graphs[p].dependencies.nil?
      deps = dependency_graphs[p].dependencies
      puts deps.to_s.lightblue

      begin
        puts dependency_graphs[p].order
      rescue RuntimeError => e
        puts e.message.lightred
      rescue TSort::Cyclic => e
        puts "Circular dependency detected: #{e.message}".lightred
      end
    end
  end

  def self.read_filelist(path, always_calcuate_from_disk: false)
    filelist = File.readlines(path, chomp: true)
    if filelist.first&.start_with?('# Total size') && !always_calcuate_from_disk
      return [filelist.first[/Total size: (\d+)/, 1].to_i, filelist]
    else
      return [get_package_disk_size(filelist), filelist]
    end
  end

  def self.save_json(json_object)
    crewlog 'Saving device.json...'
    begin
      File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
    rescue StandardError => e
      puts "Error writing updated packages json file!\n#{e.message}".lightred
      abort
    end

    # Copy over original if the write to the tmp file succeeds.
    FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
  end

  def self.libtoolize(library, lib_pkg_name = nil, install_dest = nil)
    install_dest = false if install_dest.nil?
    lib_pkg_name = library if lib_pkg_name.nil?
    libname = library.to_s.start_with?('lib') ? library.downcase : "lib#{library.downcase}"
    puts "Generating libtool file for #{lib_pkg_name}".orange
    puts "grep \"#{CREW_LIB_PREFIX}/#{libname}.so\\\|#{CREW_DEST_LIB_PREFIX}/#{libname}-*.so\" #{CREW_META_PATH}/#{lib_pkg_name}.filelist" if CREW_VERBOSE
    libnames = `grep "#{CREW_LIB_PREFIX}/#{libname}.so\\\|#{CREW_DEST_LIB_PREFIX}/#{libname}-*.so*" #{CREW_META_PATH}/#{lib_pkg_name}.filelist`.chomp.split(/$/).map(&:strip)
    libnames.each do |s|
      s.gsub!("#{CREW_LIB_PREFIX}/", '')
    end
    return if libnames.empty?
    dlname = libnames.grep(/.so(.)?/).first
    libname = dlname.gsub(/.so(.\d+)?/, '')
    longest_libname = libnames.max_by(&:length)
    libvars = longest_libname.rpartition('.so.')[2].split('.')

    libtool_file = <<~LIBTOOLEOF
      # #{libname}.la - a libtool library file
      # Generated by libtool (GNU libtool) (Created by Chromebrew)
      #
      # Please DO NOT delete this file!
      # It is necessary for linking the library.

      # The name that we can dlopen(3).
      dlname='#{dlname}'

      # Names of this library.
      library_names='#{libnames.reverse.join(' ')}'

      # The name of the static archive.
      old_library='#{libname}.a'

      # Linker flags that cannot go in dependency_libs.
      inherited_linker_flags=''

      # Libraries that this one depends upon.
      dependency_libs=''

      # Names of additional weak libraries provided by this library
      weak_library_names=''

      # Version information for #{library}.
      current=#{libvars[1]}
      age=#{libvars[1]}
      revision=#{libvars[2]}

      # Is this an already installed library?
      installed=yes

      # Should we warn about portability when linking against -modules?
      shouldnotlink=no

      # Files to dlopen/dlpreopen
      dlopen=''
      dlpreopen=''

      # Directory that this library needs to be installed in:
      libdir='#{CREW_LIB_PREFIX}'
    LIBTOOLEOF
    File.write("#{libname}.la", libtool_file)
    %W[#{CREW_LIB_PREFIX}/#{libname}.la #{"#{CREW_DEST_LIB_PREFIX}/#{libname}.la" if install_dest}].reject(&:blank?).each do |lib|
      FileUtils.install "#{libname}.la", lib, mode: 0o755
      puts "Generated #{lib}..."
    end
  end

  def self.patch(patch_array = [])
    return if patch_array.empty?
    patch_array.each do |patch_item|
      abort 'Patch array is not valid!'.lightred unless patch_item[0]
      abort 'Patch sha256sum does not exist!'.lightred unless patch_item[1]
      # Remove special characters from url when determining patch_file
      # name.
      patch_file = File.basename(patch_item[0]).gsub(/[^\w\s]/, '')
      puts "downloader #{patch_item[0]}, #{patch_item[1]}, #{patch_file}" if CREW_VERBOSE
      downloader patch_item[0], patch_item[1], patch_file
      puts "patch -Np1 -i #{patch_file}" if CREW_VERBOSE
      system "patch -Np1 -i #{patch_file}"
    end
  end

  def self.set_default_browser(browser_name, browser_binary)
    print "\nSet #{browser_name} as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf browser_binary, 'x-www-browser'
      end
      puts "#{browser_name} is now your default browser.".lightgreen
    else
      puts 'No change has been made.'.orange
    end
    ExitMessage.add "\nType '#{browser_binary}' to get started.\n"
  end

  def self.unset_default_browser(browser_name, browser_binary)
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') &&
         ["#{CREW_PREFIX}/share/#{browser_name.downcase}/#{browser_binary}",
          "#{CREW_PREFIX}/bin/#{browser_binary}"].include?(File.realpath('x-www-browser'))
        FileUtils.rm "#{CREW_PREFIX}/bin/x-www-browser"
      end
    end
  end
end
