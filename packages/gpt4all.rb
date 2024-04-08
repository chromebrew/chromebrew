require 'package'

class Gpt4all < Package
  description 'A free-to-use, locally running, privacy-aware chatbot.'
  homepage 'https://gpt4all.io/'
  version '2.7.3'
  license 'Copyright 2023 Nomic, Inc., Aaron Miller'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url 'https://github.com/nomic-ai/gpt4all/releases/download/v2.7.3/gpt4all-installer-linux-v2.7.3.run'
  source_sha256 '7be3ec0a86fd658db87dff64f55d074bb34553a475d1c27a49141e5e681351a2'

  depends_on 'xcb_util_image'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.chmod 0o755, 'gpt4all-installer-linux-v2.7.3.run'
    FileUtils.mkdir_p %W[#{HOME}/Desktop #{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/gpt4all]
    system "yes | ./gpt4all-installer-linux-v2.7.3.run in -t #{CREW_DEST_PREFIX}/share/gpt4all --al"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gpt4all/bin/chat", "#{CREW_DEST_PREFIX}/bin/chat"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gpt4all/bin/chat", "#{CREW_DEST_PREFIX}/bin/gpt4all"
    FileUtils.install "#{HOME}/Desktop/GPT4All.desktop", "#{CREW_DEST_PREFIX}/share/applications/GPT4All.desktop", mode: 0o644
    FileUtils.rm "#{HOME}/Desktop/GPT4All.desktop"
  end

  def self.postinstall
    ExitMessage.add "\nExecute 'chat' or 'gpt4all' to get started.\n".lightblue
  end
end
