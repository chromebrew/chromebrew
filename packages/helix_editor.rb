require 'package'

class Helix_editor < Package                 # The first character of the class name must be upper case
  description 'A vim like editor with LSP support'
  homepage 'https://helix-editor.com/'
  version '22.12'
  license 'MPL-2.0' # license of source
  compatibility 'all'
  source_url 'https://github.com/helix-editor/helix/archive/refs/tags/22.12.tar.gz'
  source_sha256 'edae8af46401b45c3e71c38b4fa99f931c4458127978ccd1b29aaae79331d972'   # Use the command "sha256sum"
  #source_url 'file:///usr/local/home/helix/deleteme.tar.gz'
  #source_sha256 'c3a0e022a7bcd6b139ae7abf1e0dae33c8f9ec82dc680076d9e5ea6593b85bc6'

  depends_on 'rust' => :build

  # TODO is it the appropriate location?
  # By default, helix expects runtime to be in ~/.config or XDG_CONFIG_HOME.
  # The first location is not appropriate because helix will not be installed in ~/
  # With the second location crew complaints that it is not  FHS3 compliant.
  @runtime_dest_dir_suffix = "/var/lib/helix"

  def self.build
   puts "Building. This may be long."
   system "cargo build \
      --release \
      --locked \
     "
  end

  def self.install
    # Copy executable
    helix_executable_dest_dir = "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p("#{helix_executable_dest_dir}")
    FileUtils.cp("./target/release/hx", "#{helix_executable_dest_dir}")
    # Copy runtime dir
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}#{@runtime_dest_dir_suffix}")
    FileUtils.cp_r("./runtime", "#{CREW_DEST_PREFIX}#{@runtime_dest_dir_suffix}")
    # Set env var for runtime dir
    env_dir = "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{env_dir}"
    File.write("#{env_dir}/helix",
               "export HELIX_RUNTIME=#{CREW_PREFIX}#{@runtime_dest_dir_suffix}/runtime")
    # system "source #{env_dir}/helix"
  end

  def self.check
    # # TODO (verify that this check works, and if it fails when the system language
    # #  is not english)
    # helix_health = capture(:stdout) { system("hx --health") }
    # return !helix_health.contains('Runtime directory does not exist')
    return true
  end

  def self.remove
    # Some files in the directory are write protected...
    FileUtils.rm_rf("#{CREW_PREFIX}#{@runtime_dest_dir_suffix}")
    # TODO if a local ~/.config/helix folder is found, ask user if he wishes to remove it
  end

  def self.postinstall
    puts <<~EOT2.orange
      Restart a new shell for helix environnement variables to be set. 
      
      Use the 'hx' command to start helix.
    
      Use 'hx --health' to see if helix detects its runtime and to see which LSP 
      servers are detected.
    
      To use the default theme, helix has to be started in a terminal it recognizes 
      as supporting true colors.
    EOT2
  end
end
