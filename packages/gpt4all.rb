require 'package'

class Gpt4all < Package
  description 'A free-to-use, locally running, privacy-aware chatbot.'
  homepage 'https://www.nomic.ai/gpt4all'
  version '3.0.0'
  license 'Copyright 2023 Nomic, Inc., Aaron Miller'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/nomic-ai/gpt4all/releases/download/v#{version}/gpt4all-installer-linux-v#{version}.run"
  source_sha256 '5b08bee88cea2c5a8dd9dc70ee5e4cbc76df4f8204b9c869a54b698822372f91'

  depends_on 'xcb_util_image'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.chmod 0o755, "gpt4all-installer-linux-v#{version}.run"
    FileUtils.mkdir_p %W[#{HOME}/Desktop #{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/gpt4all]
    system "yes | ./gpt4all-installer-linux-v#{version}.run in -t #{CREW_DEST_PREFIX}/share/gpt4all --al"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gpt4all/bin/chat", "#{CREW_DEST_PREFIX}/bin/chat"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gpt4all/bin/chat", "#{CREW_DEST_PREFIX}/bin/gpt4all"
    FileUtils.install "#{HOME}/Desktop/GPT4All.desktop", "#{CREW_DEST_PREFIX}/share/applications/GPT4All.desktop", mode: 0o644
    FileUtils.rm "#{HOME}/Desktop/GPT4All.desktop"
  end

  def self.postinstall
    ExitMessage.add "\nExecute 'chat' or 'gpt4all' to get started.\n"
  end
end
