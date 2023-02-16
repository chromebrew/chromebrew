require 'package'

class Helix_editor < Package
  description 'A vim inspired editor with LSP support'
  homepage 'https://helix-editor.com/'
  version '22.12'
  license 'MPL-2.0' # license of source
  compatibility 'all'
  source_url 'https://github.com/helix-editor/helix/archive/22.12.tar.gz' #'https://t.ly/-vk7'
  source_sha256 'edae8af46401b45c3e71c38b4fa99f931c4458127978ccd1b29aaae79331d972' # Use the command "sha256sum"

  depends_on 'rust' => :build
  depends_on 'xdg_base'

  @no_fhs = true

  @xdg_config_home = ENV.fetch 'XDG_CONFIG_HOME', "#{CREW_PREFIX}/.config"
  @helix_runtime_dir = "#{@xdg_config_home}/helix"

  def self.build
    puts 'Building. This may be long.'
    system "cargo build \
      --release \
      --locked \
     "
  end

  def self.check
    # This will raise an error if "hx" is not a valid command
    `hx --version`
    # Check if helix can find its runtime path
    command_output = `hx --health`
    if !command_output.include?(@helix_runtime_dir.to_s)
      raise 'Helix cannot find its runtime dir'
    end
  end


  def self.install
    # Copy executable
    helix_executable_dest_dir = "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p helix_executable_dest_dir.to_s
    FileUtils.install './target/release/hx', helix_executable_dest_dir.to_s, :mode => 0755
    # Copy runtime dir
    helix_runtime_dest_dir = "#{CREW_DEST_DIR}#{@helix_runtime_dir}"
    FileUtils.mkdir_p helix_runtime_dest_dir.to_s
    FileUtils.cp_r './runtime', helix_runtime_dest_dir.to_s
  end

  def self.postinstall
    puts <<~EOT2.orange
      Use the 'hx' command to start helix.

      Use 'hx --health' to see if helix can find its runtime and to see which LSP
      servers are detected.

      To be able to load some themes, helix needs to be started in a terminal it recognizes#{' '}
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
