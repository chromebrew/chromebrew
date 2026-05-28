require 'package'

class Ghidra < Package
  description "A software reverse engineering (SRE) suite of tools developed by NSA's Research Directorate in support of the Cybersecurity mission."
  homepage 'https://ghidra-sre.org/'
  version '12.1-20260513'
  license 'Apache 2.0'
  compatibility 'x86_64'
  source_url "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_#{version.split('-')[0]}_build/ghidra_#{version.split('-')[0]}_PUBLIC_#{version.split('-')[1]}.zip"
  source_sha256 'aa5cbcbbf48f41ca185fce900e19592f1ade4cd5994eb6e0ede468dac8a6f302'

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libmd' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'libxext' => :library
  depends_on 'libxi' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxtst' => :library
  depends_on 'openjdk21' => :executable
  depends_on 'pthread_stubs' => :library
  depends_on 'xcb_proto' => :library
  depends_on 'xorg_proto' => :library

  no_compile_needed

  def self.preflight
    # Need at least 1.2 gb.
    MiscFunctions.check_free_disk_space(1288490188)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ghidra"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/ghidra"
    FileUtils.ln_s "#{CREW_PREFIX}/share/ghidra/ghidraRun", "#{CREW_DEST_PREFIX}/bin/ghidra"
    # Remove batch files that only work on Windows.
    system "find #{CREW_DEST_PREFIX}/share/ghidra -name '*.bat' -exec rm {} +"
  end

  def self.postinstall
    ExitMessage.add "\nType 'ghidra' to get started.\n"
  end
end
