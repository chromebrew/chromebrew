require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  version '3.9.4'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: '8490f1d4a137e6b9edc628f7fe56bfa2d93ea22d07981b37bcb08c4248f03be8',
     armv7l: '8490f1d4a137e6b9edc628f7fe56bfa2d93ea22d07981b37bcb08c4248f03be8',
     x86_64: '61b4b9488e1b4255b94be17ad48ae2ddb23c6fbe67824cf8103d0b28fa8ab816'
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
