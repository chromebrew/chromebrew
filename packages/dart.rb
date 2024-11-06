require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  version '3.4.4'
  license 'BSD-3'
  compatibility 'all'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
       i686: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-ia32-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: '2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e',
     armv7l: '2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e',
       i686: 'a2ce567c7953c901af15e5ce89436d611f601bbc64f0f4a920700e9f1d61f902',
     x86_64: '1968cc9ee12802317f9a2320165f6966cf949dc3574cac1cb91a1bc7f0de67db'
  })

  no_compile_needed
  no_shrink

  def self.install
    dart_prefix = File.join(CREW_LIB_PREFIX, 'dart')

    FileUtils.mkdir_p [CREW_DEST_LIB_PREFIX, File.join(CREW_DEST_PREFIX, 'bin')]
    FileUtils.cp_r '.', File.join(CREW_DEST_DIR, dart_prefix)

    FileUtils.ln_s File.join(dart_prefix, 'bin/dart'), File.join(CREW_DEST_PREFIX, 'bin/dart')
  end
end
