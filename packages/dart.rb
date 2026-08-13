require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  version '3.13.0'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: 'd75787da6fcba9362ddcf0643443b04962e280ab09dc48b05ab49e6538e013ee',
     armv7l: 'd75787da6fcba9362ddcf0643443b04962e280ab09dc48b05ab49e6538e013ee',
     x86_64: '87902573facd8acacac7ee1fe73fa8d0668e06065016068e2ed6c5c99c6b1ee0'
  })

  conflicts_with 'flutter'
  no_compile_needed
  no_shrink

  def self.install
    dart_prefix = File.join(CREW_LIB_PREFIX, 'dart')

    FileUtils.mkdir_p [CREW_DEST_LIB_PREFIX, File.join(CREW_DEST_PREFIX, 'bin')]
    FileUtils.cp_r '.', File.join(CREW_DEST_DIR, dart_prefix)

    FileUtils.ln_s File.join(dart_prefix, 'bin/dart'), File.join(CREW_DEST_PREFIX, 'bin/dart')
  end
end
