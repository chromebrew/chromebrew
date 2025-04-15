require 'package'

class Speakify < Package
  description 'Speakify is a web application that uses Edge TTS to convert text to speech using a variety of voices.'
  homepage 'https://github.com/habitual69/speakify'
  version '07f685a07b0ee3c89c3c4d19a1a22ec84a57cd4f-py3.13'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'https://github.com/habitual69/speakify.git'
  git_hashtag version.split('-').first

  depends_on 'python3' # R

  no_compile_needed

  def self.build
    File.write 'speakify.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/speakify
      python3 main.py
    EOF
  end

  def self.install
    FileUtils.rm_rf Dir['.git*']
    system 'pip install -r requirements.txt'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/speakify"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/speakify"
    FileUtils.install 'speakify.sh', "#{CREW_DEST_PREFIX}/bin/speakify", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'speakify' to get started."
  end
end
