require 'package'

class Helix_editor < Package
  description 'A vim inspired editor with LSP support'
  homepage 'https://helix-editor.com/'
  version '22.12'
  license 'MPL-2.0' # license of source
  compatibility 'all'
  source_url 'https://t.ly/-vk7'
  source_sha256 'edae8af46401b45c3e71c38b4fa99f931c4458127978ccd1b29aaae79331d972' # Use the command "sha256sum"
  source_url 'file:///usr/local/home/helix/deleteme.tar.gz'
  source_sha256 'c3a0e022a7bcd6b139ae7abf1e0dae33c8f9ec82dc680076d9e5ea6593b85bc6'

  depends_on 'rust' => :build
  depends_on 'xdg_base'

  @no_fhs = true

  @xdg_config_home = ENV.fetch 'XDG_CONFIG_HOME', '/usr/local/.config'
  @helix_runtime_dir = "#{@xdg_config_home}/helix"

  def self.build
    puts 'Building. This may be long.'
    puts 'cargo build \
      --release \
      --locked \
     '
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
end
