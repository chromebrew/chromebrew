require 'package'

class Netbeans < Package
  description 'Apache NetBeans IDE is free open source software to quickly and easily develop desktop, mobile, and web applications with Java, JavaScript, HTML5, PHP, C/C++ and more.'
  homepage 'https://netbeans.apache.org/front/main/index.html'
  version '28'
  license 'Apache-2.0, custom, EPL-1.0, W3C, MIT, BSD, MPL-1.0, CC-BY-3.0, CDDL and CDDL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/netbeans/netbeans/#{version}/netbeans-#{version}-bin.zip"
  source_sha256 '00b9fa5c02c07106dfeb37a889e2a04e3e2c522b36e15cf37d31ee90fa1afc32'

  depends_on 'openjdk17'
  depends_on 'libxtst'
  depends_on 'sommelier' => :logical

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.rm Dir['bin/*.exe']
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.ln_s "#{CREW_PREFIX}/share/netbeans/bin/netbeans", "#{CREW_DEST_PREFIX}/bin/netbeans"
  end

  def self.postinstall
    ExitMessage.add "\nType 'netbeans' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.netbeans")
  end
end
