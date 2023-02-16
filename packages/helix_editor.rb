require 'package'

class Helix_editor < Package                 # The first character of the class name must be upper case
  description 'A vim inspired editor with LSP support'
  homepage 'https://helix-editor.com/'
  version '22.12'
  license 'MPL-2.0' # license of source
  compatibility 'all'
  source_url 'https://github.com/helix-editor/helix/archive/refs/tags/22.12.tar.gz'
  source_sha256 'edae8af46401b45c3e71c38b4fa99f931c4458127978ccd1b29aaae79331d972'   # Use the command "sha256sum"
  
  depends_on 'rust' => :build

  @no_fhs = true
  
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
    helix_runtime_dest_dir = "#{CREW_DEST_DIR}#{ENV['XDG_CONFIG_HOME']}/helix"
    FileUtils.mkdir_p("#{helix_runtime_dest_dir}")
    FileUtils.cp_r("./runtime", "#{helix_runtime_dest_dir}")
  end

  def self.check
    puts "self.check is called"
    return false
    # Check "hx --version" status code and if hx found its runtime directory
    # return (system "hx --version") && (`hx --health`.include?("#{ENV['XDG_CONFIG_HOME']}"))
  end

  def self.postinstall
    puts <<~EOT2.orange
      Use the 'hx' command to start helix.
    
      Use 'hx --health' to see if helix detects its runtime and to see which LSP 
      servers are detected.
    
      To be able to load some themes, helix neefds to be started in a terminal it recognizes 
      as supporting true colors.
    EOT2
  end
end
