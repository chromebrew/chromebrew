require 'package'
require_relative 'gcloud'

class Google_cloud_sdk < Package
  description Gcloud.description
  homepage Gcloud.homepage
  version Gcloud.version
  license Gcloud.license
  compatibility Gcloud.compatibility

  is_fake

  depends_on 'gcloud'
end
