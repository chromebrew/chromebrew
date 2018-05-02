require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '1.24.3'
  case ARCH
  when 'aarch64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.3/sdk/dartsdk-linux-arm64-release.zip'
    source_sha256 '306b77529f5487ccef3df36c915bd6fc7d5ad1b385d7f735832ca4fc08b0abdc'
  when 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.3/sdk/dartsdk-linux-arm-release.zip'
    source_sha256 'c5cb7b453a29396edcca34a32697cf5331feb645d9b3c1ba48f106f609672a23'
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.3/sdk/dartsdk-linux-ia32-release.zip'
    source_sha256 'd67b8f8f9186e7d460320e6bce25ab343c014b6af4b2f61369ee83755d4da528'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.3/sdk/dartsdk-linux-x64-release.zip'
    source_sha256 'e323c97c35e6bc5d955babfe2e235a5484a82bb1e4870fa24562c8b9b800559b'
#
#  comment out abort per discussion in #798
#  https://github.com/skycocker/chromebrew/pull/798
#  we have all current archs covered here anyway, i believe
#
#  else
#    abort 'Unable to install dart sdk.  Architecture not supported.'.lightred
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'unzip' => :build

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/* #{CREW_DEST_LIB_PREFIX}"
    system "cp -r include/ #{CREW_DEST_PREFIX}"
    system "cp version #{CREW_DEST_PREFIX}" # This stops 'pub get' from throwing errors
  end
end
