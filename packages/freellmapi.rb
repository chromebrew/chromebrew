require 'package'

class Freellmapi < Package
  description 'Aggregate free tiers from dozens of LLM providers'
  homepage 'https://freellmapi.co/'
  version '0.16.51'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/tashfeenahmed/freellmapi/releases/download/v#{version}/FreeLLMAPI-#{version}.AppImage"
  source_sha256 '5e43b98caf1888d9381e143dfb00c8e6eabcae856e35a003b21e7ed819523bf9'

  depends_on 'gtk3' => :logical

  no_compile_needed
  no_shrink

  def self.patch
    system "sed -i 's,AppRun,freellmapi,' freellmapi-desktop.desktop"
    system "sed -i '24iAPPDIR=#{CREW_PREFIX}/share/freellmapi' AppRun"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/freellmapi"
    FileUtils.install 'freellmapi-desktop.desktop', "#{CREW_DEST_PREFIX}/share/applications/freellmapi-desktop.desktop", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/freellmapi/AppRun", "#{CREW_DEST_PREFIX}/bin/freellmapi"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/freellmapi"
  end

  def self.postinstall
    ExitMessage.add "\nType 'freellmapi' to get started.\n"
  end
end
