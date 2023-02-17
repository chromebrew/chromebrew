require 'package'

class Helix_editor < Package
  description 'A vim inspired editor with LSP support'
  homepage 'https://helix-editor.com/'
  version '22.12'
  license 'MPL-2.0' # license of source
  compatibility 'all'
  source_url 'https://github.com/helix-editor/helix/archive/22.12.tar.gz'
  source_sha256 'edae8af46401b45c3e71c38b4fa99f931c4458127978ccd1b29aaae79331d972' # Use the command "sha256sum"

  depends_on 'rust' => :build
  depends_on 'xdg_base'

  @no_fhs = true

  @xdg_config_home = ENV.fetch 'XDG_CONFIG_HOME', "#{CREW_PREFIX}/.config"
  @helix_runtime_dir = "#{@xdg_config_home}/helix"
  @build_folder_suffix = '/target/release'

  def self.build
    puts 'Building. This may be long.'
    system 'cargo build \
      --release \
      --locked \
     '
  end

  def self.install
    # Copy executable
    helix_executable_dest_dir = "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p helix_executable_dest_dir.to_s
    FileUtils.install ".#{@build_folder_suffix}/hx", helix_executable_dest_dir, mode: 0o755
    # Copy runtime dir
    helix_runtime_dest_dir = "#{CREW_DEST_DIR}#{@helix_runtime_dir}"
    FileUtils.mkdir_p helix_runtime_dest_dir
    FileUtils.cp_r './runtime', helix_runtime_dest_dir
  end

  def self.check
    # Ensure hx is executable
    command_status = system ".#{@build_folder_suffix}/hx --version"
    raise 'hx is not executable' unless command_status == true
  end

  def self.postinstall
    # This will print a warning if "hx" is not a valid command
    command_status = system 'hx --version'
    puts 'Warning: hx is not in path'.red unless command_status == true
    # Check if helix can find its runtime path
    command_output = `hx --health`
    puts 'Warning: helix cannot find its runtime dir'.red unless command_output.include? @helix_runtime_dir

    puts <<~EOT2.orange
      Use the 'hx' command to start helix.
      Use 'hx --health' to see if helix can find its runtime and to see which LSP
      servers are detected.
      Note that to be able to load some themes, helix needs to be started in a terminal it recognizes
      as supporting true colors.
    EOT2
  end

  def self.remove
    # Some files in the directory are write protected...
    FileUtils.rm_rf @helix_runtime_dir
    # If the user added a configuration dir, we ask if he wishes to remove it as well
    config_dir = "#{HOME}/.config/helix"
    Dir.exist? config_dir
    puts "\nWould you like to remove the configuration folder: #{config_dir}? [y/N] "
    case $stdin.gets.chomp.downcase
    when 'y', 'yes'
      FileUtils.rm_rf config_dir
      puts "#{config_dir} removed.".lightred
    else
      puts "#{config_dir} was not removed.".lightgreen
    end
  end
end
