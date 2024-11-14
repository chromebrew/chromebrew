require 'package'

class Ghidra < Package
  description "A software reverse engineering (SRE) suite of tools developed by NSA's Research Directorate in support of the Cybersecurity mission."
  homepage 'https://ghidra-sre.org/'
  version '11.0.3'
  license 'Apache 2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.3_build/ghidra_11.0.3_PUBLIC_20240410.zip'
  source_sha256 '2462a2d0ab11e30f9e907cd3b4aa6b48dd2642f325617e3d922c28e752be6761'

  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'libxrender' # R
  depends_on 'libxtst' # R
  depends_on 'openjdk17' # R
  depends_on 'pthread_stubs' # R
  depends_on 'xcb_proto' # R
  depends_on 'xorg_proto' # R

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ghidra"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/ghidra"
    FileUtils.ln_s "#{CREW_PREFIX}/share/ghidra/ghidraRun", "#{CREW_DEST_PREFIX}/bin/ghidra"
  end

  def self.postinstall
    ExitMessage.add "\nType 'ghidra' to get started.\n".lightblue
  end
end
